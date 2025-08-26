//! Implements fucntions to test the NIF functionality and datastructure
//! serialization between Rust and Elixir (or other languages implementing this
//! nif).

use arm::action::{create_an_action, create_multiple_actions, Action};
use arm::action_tree::MerkleTree;
use arm::compliance::{ComplianceInstance, ComplianceWitness};
use arm::compliance_unit::ComplianceUnit;
use arm::delta_proof::{DeltaProof, DeltaWitness};
use arm::logic_instance::{AppData, ExpirableBlob};
use arm::logic_proof::{LogicProver, LogicVerifier, LogicVerifierInputs};
use arm::merkle_path::{MerklePath, COMMITMENT_TREE_DEPTH};
use arm::nullifier_key::{NullifierKey, NullifierKeyCommitment};
use arm::resource::Resource;
use arm::resource_logic::TrivialLogicWitness;
use arm::transaction::{Delta, Transaction};
use k256::ecdsa::SigningKey;
use rand::random;
use risc0_zkvm::sha::Digest;
use rustler::nif;

//----------------------------------------------------------------------------//
//                                Delta Witness                               //
//----------------------------------------------------------------------------//

#[nif]
/// Create a random delta witness to return from the NIF.
fn test_delta_witness() -> DeltaWitness {
    // create a random delta witness
    use k256::ecdsa::SigningKey;
    use k256::elliptic_curve::rand_core::OsRng;

    let mut rng = OsRng;
    let signing_key = SigningKey::random(&mut rng);

    DeltaWitness { signing_key }
}

#[nif]
fn test_delta_witness(delta_witness: DeltaWitness) -> DeltaWitness {
    delta_witness
}

//----------------------------------------------------------------------------//
//                                Delta                                       //
//----------------------------------------------------------------------------//

#[nif]
/// Create a Delta with a witness.
fn test_delta_with_witness() -> Delta {
    // create a random delta witness
    use k256::ecdsa::SigningKey;
    use k256::elliptic_curve::rand_core::OsRng;

    let mut rng = OsRng;
    let signing_key = SigningKey::random(&mut rng);

    let dw: DeltaWitness = DeltaWitness {
        signing_key: signing_key,
    };

    Delta::Witness(dw)
}

#[nif]
fn test_delta_with_witness(delta: Delta) -> Delta {
    delta
}

#[nif]
/// Create a Delta with a proof.
fn test_delta_with_proof() -> Delta {
    use k256::elliptic_curve::rand_core::OsRng;

    let mut rng = OsRng;
    let signing_key = SigningKey::random(&mut rng);
    let message = b"Hello, world!";
    let witness = DeltaWitness { signing_key };
    let dp = DeltaProof::prove(message, &witness);
    Delta::Proof(dp)
}

#[nif]
fn test_delta_with_proof(delta: Delta) -> Delta {
    delta
}

//----------------------------------------------------------------------------//
//                                Compliance Instance                         //
//----------------------------------------------------------------------------//

#[nif]
/// Create an arbitrary ComplianceInstance and return it.
fn test_compliance_instance() -> ComplianceInstance {
    let nonce = 1;
    let nf_key = NullifierKey::default();
    let nf_key_cm = nf_key.commit();
    let mut consumed_resource = Resource {
        logic_ref: TrivialLogicWitness::verifying_key_as_bytes(),
        nk_commitment: nf_key_cm,
        ..Default::default()
    };
    consumed_resource.nonce[0] = nonce;
    let mut created_resource = consumed_resource.clone();
    let consumed_resource_nf = consumed_resource.nullifier(&nf_key).unwrap();

    created_resource.set_nonce(consumed_resource_nf.clone().as_bytes().to_vec());

    let compliance_witness = ComplianceWitness::<COMMITMENT_TREE_DEPTH>::with_fixed_rcv(
        consumed_resource.clone(),
        nf_key.clone(),
        created_resource.clone(),
    );
    let compliance_receipt = ComplianceUnit::create(&compliance_witness);
    compliance_receipt.get_instance()
}

#[nif]
/// Return the ComplianceInstance.
fn test_compliance_instance(compliance_instance: ComplianceInstance) -> ComplianceInstance {
    compliance_instance
}

//----------------------------------------------------------------------------//
//                                Compliance Unit                             //
//----------------------------------------------------------------------------//

#[nif]
/// Create an arbitrary CompliaceUnit and return it.
fn test_compliance_unit() -> ComplianceUnit {
    let nonce = 1;
    let nf_key = NullifierKey::default();
    let nf_key_cm = nf_key.commit();
    let mut consumed_resource = Resource {
        logic_ref: TrivialLogicWitness::verifying_key_as_bytes(),
        nk_commitment: nf_key_cm,
        ..Default::default()
    };
    consumed_resource.nonce[0] = nonce;
    let mut created_resource = consumed_resource.clone();
    let consumed_resource_nf = consumed_resource.nullifier(&nf_key).unwrap();
    created_resource.set_nonce(consumed_resource_nf.clone().as_bytes().to_vec());

    let compliance_witness = ComplianceWitness::<COMMITMENT_TREE_DEPTH>::with_fixed_rcv(
        consumed_resource.clone(),
        nf_key.clone(),
        created_resource.clone(),
    );
    let compliance_receipt = ComplianceUnit::create(&compliance_witness);
    compliance_receipt
}

#[nif]
fn test_compliance_unit(compliance_unit: ComplianceUnit) -> ComplianceUnit {
    compliance_unit
}

//----------------------------------------------------------------------------//
//                                Merkle Tree                                 //
//----------------------------------------------------------------------------//

#[nif]
/// Create a default merkle path.
fn test_merkle_path() -> MerklePath<COMMITMENT_TREE_DEPTH> {
    MerklePath::default()
}

#[nif]
fn test_merkle_path(
    merkle_path: MerklePath<COMMITMENT_TREE_DEPTH>,
) -> MerklePath<COMMITMENT_TREE_DEPTH> {
    merkle_path
}

#[nif]
/// Create a default merkle tree.
fn test_merkle_tree() -> MerkleTree {
    MerkleTree::new(vec![Digest::default()])
}

#[nif]
fn test_merkle_tree(merkle_tree: MerkleTree) -> MerkleTree {
    merkle_tree
}

//----------------------------------------------------------------------------//
//                                Compliance Witness                          //
//----------------------------------------------------------------------------//

#[nif]
/// Create an arbitrary compliance witness and return it.
fn test_compliance_witness() -> ComplianceWitness<COMMITMENT_TREE_DEPTH> {
    let nonce = 1;
    let nf_key = NullifierKey::default();
    let nf_key_cm = nf_key.commit();
    let mut consumed_resource = Resource {
        logic_ref: TrivialLogicWitness::verifying_key_as_bytes(),
        nk_commitment: nf_key_cm,
        ..Default::default()
    };
    consumed_resource.nonce[0] = nonce;
    let mut created_resource = consumed_resource.clone();
    created_resource.set_nonce_from_nf(&consumed_resource, &nf_key);
    let compliance_witness = ComplianceWitness::<COMMITMENT_TREE_DEPTH>::with_fixed_rcv(
        consumed_resource.clone(),
        nf_key.clone(),
        created_resource.clone(),
    );
    compliance_witness
}

#[nif]
fn test_compliance_witness(compliance_witness: ComplianceWitness<32>) -> ComplianceWitness<32> {
    compliance_witness
}

//----------------------------------------------------------------------------//
//                                Logic Proof                                 //
//----------------------------------------------------------------------------//

#[nif]
fn test_logic_verifier() -> LogicVerifier {
    let nonce = 1;

    let nf_key = NullifierKey::default();
    let nf_key_cm = nf_key.commit();
    let mut consumed_resource = Resource {
        logic_ref: TrivialLogicWitness::verifying_key_as_bytes(),
        nk_commitment: nf_key_cm,
        ..Default::default()
    };
    consumed_resource.nonce[0] = nonce;
    let created_resource = consumed_resource.clone();

    let consumed_resource_nf = consumed_resource.nullifier(&nf_key).unwrap();
    let created_resource_cm = created_resource.commitment();
    let action_tree = MerkleTree::new(vec![
        consumed_resource_nf.clone().into(),
        created_resource_cm.clone().into(),
    ]);
    let consumed_resource_path = action_tree.generate_path(&consumed_resource_nf).unwrap();

    let consumed_logic_witness = TrivialLogicWitness::new(
        consumed_resource,
        consumed_resource_path,
        nf_key.clone(),
        true,
    );
    let consumed_logic_proof = consumed_logic_witness.prove();
    consumed_logic_proof
}

#[nif]
fn test_logic_verifier(logic_verifier: LogicVerifier) -> LogicVerifier {
    logic_verifier
}

//----------------------------------------------------------------------------//
//                                Resource                                    //
//----------------------------------------------------------------------------//

#[nif]
/// Create an arbitrary resource and return it.
fn test_resource() -> Resource {
    let nf_key = NullifierKey::default();
    let nf_key_cm = nf_key.commit();
    let consumed_resource = Resource {
        logic_ref: TrivialLogicWitness::verifying_key_as_bytes(),
        nk_commitment: nf_key_cm,
        ..Default::default()
    };
    consumed_resource
}

#[nif]
fn test_resource(resource: Resource) -> Resource {
    resource
}

//----------------------------------------------------------------------------//
//                                Action                                      //
//----------------------------------------------------------------------------//

#[nif]
/// Create an arbitrary action and return it.
fn test_action() -> Action {
    let (action, _witness): (Action, DeltaWitness) = create_an_action(1);
    action
}

#[nif]
fn test_action(action: Action) -> Action {
    action
}
//----------------------------------------------------------------------------//
//                                Transaction                                 //
//----------------------------------------------------------------------------//

#[nif]
/// Create an arbitrary transaction and return it.
fn test_transaction() -> Transaction {
    let (actions, delta_witness) = create_multiple_actions(5);
    let tx = Transaction::create(actions, Delta::Witness(delta_witness));
    tx
}

#[nif]
fn test_transaction(transaction: Transaction) -> Transaction {
    transaction
}

//----------------------------------------------------------------------------//
//                                Mullifier Key                               //
//----------------------------------------------------------------------------//

#[nif]
/// Create an arbitrary nullifier key and return it.
fn test_nullifier_key() -> NullifierKey {
    let (nullifier_key, _) = NullifierKey::random_pair();
    nullifier_key
}

#[nif]
fn test_nullifier_key(nullifier_key: NullifierKey) -> NullifierKey {
    nullifier_key
}

//----------------------------------------------------------------------------//
//                                Mullifier Key Commitment                    //
//----------------------------------------------------------------------------//

#[nif]
/// Create arbitrary nullifier key commitment and return it.
fn test_nullifier_key_commitment() -> NullifierKeyCommitment {
    let (_, test_nullifier_key_commitment) = NullifierKey::random_pair();
    test_nullifier_key_commitment
}

#[nif]
fn test_nullifier_key_commitment(
    nullifier_key_commitment: NullifierKeyCommitment,
) -> NullifierKeyCommitment {
    nullifier_key_commitment
}

//----------------------------------------------------------------------------//
//                                Delta Proof                                 //
//----------------------------------------------------------------------------//

#[nif]
/// Create arbitrary delta proof and return it.
fn test_delta_proof() -> DeltaProof {
    use k256::elliptic_curve::rand_core::OsRng;

    let mut rng = OsRng;
    let signing_key = SigningKey::random(&mut rng);
    let message = b"Hello, world!";
    let witness = DeltaWitness { signing_key };
    DeltaProof::prove(message, &witness)
}

#[nif]
fn test_delta_proof(delta_proof: DeltaProof) -> DeltaProof {
    delta_proof
}

//----------------------------------------------------------------------------//
//                                ExpirableBlob                               //
//----------------------------------------------------------------------------//

#[nif]
/// Create arbitrary expirable blob and return it.
fn test_expirable_blob() -> ExpirableBlob {
    random_epxirable_blob()
}

#[nif]
fn test_expirable_blob(expirable_blob: ExpirableBlob) -> ExpirableBlob {
    expirable_blob
}

//----------------------------------------------------------------------------//
//                                AppData                                     //
//----------------------------------------------------------------------------//

#[nif]
/// Create arbitrary appdata and return it.
fn test_app_data() -> AppData {
    random_app_data()
}

#[nif]
fn test_app_data(app_data: AppData) -> AppData {
    app_data
}

//----------------------------------------------------------------------------//
//                                LogicVerifierInputs                         //
//----------------------------------------------------------------------------//

#[nif]
/// Create arbitrary app data and return it.
fn test_logic_verifier_inputs() -> LogicVerifierInputs {
    LogicVerifierInputs {
        tag: random_vector_u32(32),
        verifying_key: random_vector_u32(32),
        app_data: random_app_data(),
        proof: random_vector_u8(32),
    }
}

#[nif]
fn test_logic_verifier_inputs(logic_verifier_inputs: LogicVerifierInputs) -> LogicVerifierInputs {
    logic_verifier_inputs
}

//----------------------------------------------------------------------------//
//                                Helpers                                     //
//----------------------------------------------------------------------------//

fn random_vector_u32(length: u32) -> Vec<u32> {
    (0..length).map(|_| random::<u32>()).collect()
}

fn random_vector_u8(length: u32) -> Vec<u8> {
    (0..length).map(|_| random::<u8>()).collect()
}

fn random_epxirable_blob() -> ExpirableBlob {
    let expirable_blob = ExpirableBlob {
        blob: random_vector_u32(32),
        deletion_criterion: 0,
    };
    expirable_blob
}

fn random_app_data() -> AppData {
    AppData {
        resource_payload: vec![random_epxirable_blob()],
        discovery_payload: vec![random_epxirable_blob()],
        external_payload: vec![random_epxirable_blob()],
        application_payload: vec![random_epxirable_blob()],
    }
}
