use arm::action::Action;
use arm::action_tree::MerkleTree;
use arm::compliance::{ComplianceInstance, ComplianceWitness};
use arm::compliance_unit::ComplianceUnit;
use arm::delta_proof::DeltaWitness;
use arm::logic_proof::{LogicProver, LogicVerifier};
use arm::merkle_path::MerklePath;
use arm::merkle_path::COMMITMENT_TREE_DEPTH;
use arm::nullifier_key::{NullifierKey, NullifierKeyCommitment};
use arm::resource::Resource;
use arm::transaction::{Delta, Transaction};
use counter_library::counter_logic::CounterLogic;
use rand::Rng;

/// Converts a counter value into a vector of 8 bits that represents the value.
pub fn convert_counter_to_value_ref(value: u128) -> Vec<u8> {
    let mut arr = [0u8; 32];
    let bytes = value.to_le_bytes();
    arr[..16].copy_from_slice(&bytes); // left-align, right-pad with 0
    arr.to_vec()
}

/// Create a new ephemeral counter that can be consumed by an initialize transaction.
pub fn ephemeral_counter(
    (nf_key, nf_key_cm): (NullifierKey, NullifierKeyCommitment),
) -> (Resource, NullifierKey) {
    let mut rng = rand::rng();
    let label_ref: [u8; 32] = rng.random(); // Random label reference, it should be unique for each counter
    let nonce: [u8; 32] = rng.random(); // Random nonce for the ephemeral resource
    let ephemeral_resource = Resource::create(
        CounterLogic::verifying_key_as_bytes(),
        label_ref.to_vec(),
        1,
        convert_counter_to_value_ref(0u128), // Initialize with value/counter 0
        true,
        nonce.to_vec(),
        nf_key_cm,
    );
    (ephemeral_resource, nf_key)
}

// This function initializes a counter resource from an ephemeral counter
// resource and its nullifier key. It sets the resource as non-ephemeral, renews
// its randomness, resets the nonce from the ephemeral counter, and sets the
// value reference to 1 (the initial counter value). It also renews the
// nullifier key(commitment) for the counter resource.
pub fn init_counter_resource(
    (nf_key, nf_key_cm): (NullifierKey, NullifierKeyCommitment),
    ephemeral_counter: &Resource,
    ephemeral_counter_nf_key: &NullifierKey,
) -> (Resource, NullifierKey) {
    let mut init_counter = ephemeral_counter.clone();
    init_counter.is_ephemeral = false;
    init_counter.reset_randomness();
    init_counter.set_nonce_from_nf(ephemeral_counter, ephemeral_counter_nf_key);
    init_counter.set_value_ref(convert_counter_to_value_ref(1u128));
    init_counter.set_nf_commitment(nf_key_cm.clone());
    (init_counter, nf_key)
}

pub fn generate_compliance_proof(
    consumed_counter: Resource,
    nf_key: NullifierKey,
    merkle_path: MerklePath<COMMITMENT_TREE_DEPTH>,
    created_counter: Resource,
) -> (ComplianceUnit, Vec<u8>) {
    let compliance_witness = ComplianceWitness::<COMMITMENT_TREE_DEPTH>::from_resources_with_path(
        consumed_counter,
        nf_key,
        merkle_path,
        created_counter,
    );
    let compliance_unit = ComplianceUnit::create(&compliance_witness);
    (compliance_unit, compliance_witness.rcv)
}

pub fn generate_logic_proofs(
    consumed_counter: Resource,
    nf_key: NullifierKey,
    created_counter: Resource,
) -> Vec<LogicVerifier> {
    let consumed_counter_nf = consumed_counter.nullifier(&nf_key).unwrap();
    let created_counter_cm = created_counter.commitment();

    let action_tree = MerkleTree::new(vec![consumed_counter_nf, created_counter_cm]);

    let consumed_counter_path = action_tree.generate_path(&consumed_counter_nf).unwrap();
    let created_counter_path = action_tree.generate_path(&created_counter_cm).unwrap();

    let consumed_counter_logic = CounterLogic::new(
        true,
        consumed_counter.clone(),
        consumed_counter_path.clone(),
        nf_key.clone(),
        created_counter.clone(),
        created_counter_path.clone(),
    );
    let consumed_logic_proof = consumed_counter_logic.prove();

    let created_counter_logic = CounterLogic::new(
        false,
        consumed_counter,
        consumed_counter_path,
        nf_key,
        created_counter,
        created_counter_path,
    );
    let created_logic_proof = created_counter_logic.prove();

    vec![consumed_logic_proof, created_logic_proof]
}

// This function creates an initial transaction that initializes a counter
// resource. It generates a compliance proof and logic proofs, and constructs
// the transaction. The transaction is then returned along with the counter
// resource and nullifier key.
pub fn create_init_counter_tx(a: (NullifierKey, NullifierKeyCommitment), b: (NullifierKey, NullifierKeyCommitment)) -> (
    Transaction,
    Resource,
    NullifierKey,
    ComplianceUnit,
    ComplianceInstance,
) {
    let (ephemeral_counter, ephemeral_nf_key) = ephemeral_counter(a);
    let (counter_resource, counter_nf_key) =
        init_counter_resource(b, &ephemeral_counter, &ephemeral_nf_key);
    let (compliance_unit, rcv) = generate_compliance_proof(
        ephemeral_counter.clone(),
        ephemeral_nf_key.clone(),
        MerklePath::default(),
        counter_resource.clone(),
    );

    let logic_verifier_inputs = generate_logic_proofs(
        ephemeral_counter,
        ephemeral_nf_key,
        counter_resource.clone(),
    );

    let action = Action::new(vec![compliance_unit.clone()], logic_verifier_inputs);
    let delta_witness = DeltaWitness::from_bytes(&rcv);
    let mut tx = Transaction::create(vec![action], Delta::Witness(delta_witness));
    // tx.generate_delta_proof();
    (
        tx,
        counter_resource,
        counter_nf_key,
        compliance_unit.clone(),
        compliance_unit.clone().get_instance(),
    )
}
