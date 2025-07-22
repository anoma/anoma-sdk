//----------------------------------------------------------------------------//
//                                Library Calls                               //
//----------------------------------------------------------------------------//

#[rustler::nif]
fn prove(compliance_witness: ComplianceWitness<COMMITMENT_TREE_DEPTH>) -> ComplianceUnit {
    ComplianceUnit::prove(&compliance_witness)
}

#[rustler::nif]
fn prove_trivial_logic_witness(trivial_logic_witness: TrivialLogicWitness) -> LogicProof {
    TrivialLogicWitness::prove(&trivial_logic_witness)
}

#[rustler::nif]
fn prove_delta_witness(witness: DeltaWitness, message: Vec<u8>) -> DeltaProof {
    let proof = DeltaProof::prove(&message, &witness);
    proof
}
#[rustler::nif]
fn unit_instance(unit: ComplianceUnit) -> ComplianceInstance {
    unit.get_instance()
}

//----------------------------------------------------------------------------//
//                                Debugging                                   //
//----------------------------------------------------------------------------//

//----------------------------------------------------------------------------//
//                                Delta Witness                               //
//----------------------------------------------------------------------------//

use aarm::action::{create_multiple_actions, ForwarderCalldata};
use aarm_core::delta_proof::DeltaWitness;
use k256::ecdsa::SigningKey;
use std::env;

#[rustler::nif]
fn test_delta_witness() -> DeltaWitness {
    // create a random delta witness
    use k256::ecdsa::SigningKey;
    use k256::elliptic_curve::rand_core::OsRng;

    let mut rng = OsRng;
    let signing_key = SigningKey::random(&mut rng);

    DeltaWitness {
        signing_key: signing_key,
    }
}

#[rustler::nif]
fn test_delta_witness(delta_witness: DeltaWitness) -> DeltaWitness {
    delta_witness
}

//----------------------------------------------------------------------------//
//                                Delta Proof                                 //
//----------------------------------------------------------------------------//

use aarm_core::delta_proof::DeltaProof;
#[rustler::nif]
fn test_delta_proof() -> DeltaProof {
    use k256::elliptic_curve::rand_core::OsRng;

    let mut rng = OsRng;
    let signing_key = SigningKey::random(&mut rng);
    let message = b"Hello, world!";
    let witness = DeltaWitness { signing_key };
    DeltaProof::prove(message, &witness)
}

#[rustler::nif]
fn test_delta_proof(delta_proof: DeltaProof) -> DeltaProof {
    delta_proof
}

//----------------------------------------------------------------------------//
//                                Delta                                       //
//----------------------------------------------------------------------------//

use aarm::transaction::{Delta, Transaction};

#[rustler::nif]
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

#[rustler::nif]
fn test_delta_with_proof() -> Delta {
    use k256::elliptic_curve::rand_core::OsRng;

    let mut rng = OsRng;
    let signing_key = SigningKey::random(&mut rng);
    let message = b"Hello, world!";
    let witness = DeltaWitness { signing_key };
    let dp = DeltaProof::prove(message, &witness);
    Delta::Proof(dp)
}

//----------------------------------------------------------------------------//
//                                Compliance Unit                             //
//----------------------------------------------------------------------------//

use aarm_core::constants::COMMITMENT_TREE_DEPTH;

#[rustler::nif]
fn test_compliance_unit() -> ComplianceUnit {
    let nonce = 1;
    let nf_key = NullifierKey::default();
    let nf_key_cm = nf_key.commit();
    let mut consumed_resource = Resource {
        logic_ref: TrivialLogicWitness::verifying_key(),
        nk_commitment: nf_key_cm,
        ..Default::default()
    };
    consumed_resource.nonce[0] = nonce;
    let mut created_resource = consumed_resource.clone();
    created_resource.nonce[10] = nonce;

    let compliance_witness = ComplianceWitness::<COMMITMENT_TREE_DEPTH>::with_fixed_rcv(
        consumed_resource.clone(),
        nf_key.clone(),
        created_resource.clone(),
    );
    let compliance_receipt = ComplianceUnit::prove(&compliance_witness);
    compliance_receipt
}
#[rustler::nif]
fn test_compliance_unit(compliance_unit: ComplianceUnit) -> ComplianceUnit {
    compliance_unit
}

//----------------------------------------------------------------------------//
//                                Compliance Instance                         //
//----------------------------------------------------------------------------//

#[rustler::nif]
fn test_compliance_instance() -> ComplianceInstance {
    let nonce = 1;
    let nf_key = NullifierKey::default();
    let nf_key_cm = nf_key.commit();
    let mut consumed_resource = Resource {
        logic_ref: TrivialLogicWitness::verifying_key(),
        nk_commitment: nf_key_cm,
        ..Default::default()
    };
    consumed_resource.nonce[0] = nonce;
    let mut created_resource = consumed_resource.clone();
    created_resource.nonce[10] = nonce;

    let compliance_witness = ComplianceWitness::<COMMITMENT_TREE_DEPTH>::with_fixed_rcv(
        consumed_resource.clone(),
        nf_key.clone(),
        created_resource.clone(),
    );
    let compliance_receipt = ComplianceUnit::prove(&compliance_witness);
    compliance_receipt.get_instance()
}
#[rustler::nif]
fn test_compliance_instance(compliance_instance: ComplianceInstance) -> ComplianceInstance {
    compliance_instance
}

//----------------------------------------------------------------------------//
//                                Logic Proof                                 //
//----------------------------------------------------------------------------//

#[rustler::nif]
fn test_logic_proof() -> LogicProof {
    let key = "RISC0_DEV_MODE";
    match env::var(key) {
        Ok(val) => println!("{key}: {val:?}"),
        Err(e) => println!("couldn't interpret {key}: {e}"),
    }

    let nonce = 1;

    // LogicProof{
    //     instance: vec![42, 127, 203, 15, 89, 254, 33, 178, 91, 6],
    //     proof: vec![42, 127, 203, 15, 89, 254, 33, 178, 91, 7],
    //     verifying_key: vec![42, 127, 203, 15, 89, 254, 33, 178, 91, 8],
    // }
    let nf_key = NullifierKey::default();
    let nf_key_cm = nf_key.commit();
    let mut consumed_resource = Resource {
        logic_ref: TrivialLogicWitness::verifying_key(),
        nk_commitment: nf_key_cm,
        ..Default::default()
    };
    consumed_resource.nonce[0] = nonce;
    let mut created_resource = consumed_resource.clone();
    created_resource.nonce[10] = nonce;

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

#[rustler::nif]
fn test_logic_proof(logic_proof: LogicProof) -> LogicProof {
    logic_proof
}

//----------------------------------------------------------------------------//
//                                Resource                                    //
//----------------------------------------------------------------------------//

#[rustler::nif]
fn test_resource() -> Resource {
    let nf_key = NullifierKey::default();
    let nf_key_cm = nf_key.commit();
    let consumed_resource = Resource {
        logic_ref: TrivialLogicWitness::verifying_key(),
        nk_commitment: nf_key_cm,
        ..Default::default()
    };
    consumed_resource
}

#[rustler::nif]
fn test_resource(resource: Resource) -> Resource {
    resource
}

//----------------------------------------------------------------------------//
//                                Forwarder Calldata                          //
//----------------------------------------------------------------------------//

#[rustler::nif]
fn test_forwarder_calldata() -> ForwarderCalldata {
    ForwarderCalldata {
        untrusted_forwarder: [0u8; 20],
        input: vec![],
        output: vec![],
    }
}

#[rustler::nif]
fn test_forwarder_calldata(forwarder_calldata: ForwarderCalldata) -> ForwarderCalldata {
    forwarder_calldata
}

//----------------------------------------------------------------------------//
//                                Action                                      //
//----------------------------------------------------------------------------//
use aarm::action::Action;
use aarm::compliance_unit::ComplianceUnit;
use aarm::logic_proof::{LogicProof, LogicProver};
use aarm_core::action_tree::MerkleTree;
use aarm_core::compliance::{ComplianceInstance, ComplianceWitness};
use aarm_core::merkle_path::{Leaf, MerklePath};
use aarm_core::nullifier_key::{NullifierKey, NullifierKeyCommitment};
use aarm_core::resource::Resource;
use aarm_core::resource_logic::TrivialLogicWitness;

#[rustler::nif]
fn test_action() -> Action {
    Action::new(vec![], vec![], vec![])
}

#[rustler::nif]
fn test_action(action: Action) -> Action {
    action
}

//----------------------------------------------------------------------------//
//                                Mullifier Key                               //
//----------------------------------------------------------------------------//

#[rustler::nif]
fn test_nullifier_key() -> NullifierKey {
    let (nullifier_key, _) = NullifierKey::random_pair();
    nullifier_key
}

#[rustler::nif]
fn test_nullifier_key(nullifier_key: NullifierKey) -> NullifierKey {
    nullifier_key
}

//----------------------------------------------------------------------------//
//                                Mullifier Key Commitment                    //
//----------------------------------------------------------------------------//

#[rustler::nif]
fn test_nullifier_key_commitment() -> NullifierKeyCommitment {
    let (_, test_nullifier_key_commitment) = NullifierKey::random_pair();
    test_nullifier_key_commitment
}

#[rustler::nif]
fn test_nullifier_key_commitment(
    nullifier_key_commitment: NullifierKeyCommitment,
) -> NullifierKeyCommitment {
    nullifier_key_commitment
}

//----------------------------------------------------------------------------//
//                                Merkle Tree                                 //
//----------------------------------------------------------------------------//

#[rustler::nif]
fn test_leaf() -> Leaf {
    Leaf::from(vec![0u8; 32])
}

#[rustler::nif]
fn test_leaf(leaf: Leaf) -> Leaf {
    leaf
}

#[rustler::nif]
fn test_merkle_path() -> MerklePath<223> {
    MerklePath::default()
}

#[rustler::nif]
fn test_merkle_path(merkle_path: MerklePath<123>) -> MerklePath<123> {
    merkle_path
}

#[rustler::nif]
fn test_merkle_tree() -> MerkleTree {
    MerkleTree::new(vec![Leaf::from(vec![0u8; 32])])
}

#[rustler::nif]
fn test_merkle_tree(merkle_tree: MerkleTree) -> MerkleTree {
    merkle_tree
}

//----------------------------------------------------------------------------//
//                                Trivial Logic Witness                       //
//----------------------------------------------------------------------------//

#[rustler::nif]
fn test_trivial_logic_witness() -> TrivialLogicWitness {
    let nonce = 1;
    let nf_key = NullifierKey::default();
    let nf_key_cm = nf_key.commit();
    let mut consumed_resource = Resource {
        logic_ref: TrivialLogicWitness::verifying_key(),
        nk_commitment: nf_key_cm,
        ..Default::default()
    };
    consumed_resource.nonce[0] = nonce;
    let mut created_resource = consumed_resource.clone();
    created_resource.nonce[10] = nonce;

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
    consumed_logic_witness
}

#[rustler::nif]
fn test_trivial_logic_witness(trivial_logic_witness: TrivialLogicWitness) -> TrivialLogicWitness {
    trivial_logic_witness
}

//----------------------------------------------------------------------------//
//                                Compliance Witness                          //
//----------------------------------------------------------------------------//

#[rustler::nif]
fn test_compliance_witness() -> ComplianceWitness<32> {
    let nonce = 1;
    let nf_key = NullifierKey::default();
    let nf_key_cm = nf_key.commit();
    let mut consumed_resource = Resource {
        logic_ref: TrivialLogicWitness::verifying_key(),
        nk_commitment: nf_key_cm,
        ..Default::default()
    };
    consumed_resource.nonce[0] = nonce;
    let mut created_resource = consumed_resource.clone();
    created_resource.nonce[10] = nonce;

    let compliance_witness = ComplianceWitness::<COMMITMENT_TREE_DEPTH>::with_fixed_rcv(
        consumed_resource.clone(),
        nf_key.clone(),
        created_resource.clone(),
    );
    compliance_witness
}

#[rustler::nif]
fn test_compliance_witness(compliance_witness: ComplianceWitness<32>) -> ComplianceWitness<32> {
    compliance_witness
}

//----------------------------------------------------------------------------//
//                                Transaction                                 //
//----------------------------------------------------------------------------//

#[rustler::nif]
fn test() -> Transaction {
    // println!("RESOURCE_BYTES {}", RESOURCE_BYTES);
    // println!(
    //     "PRF_EXPAND_PERSONALIZATION_LEN {}",
    //     PRF_EXPAND_PERSONALIZATION_LEN + 1 + 2 * DIGEST_BYTES
    // );
    // // let action = aarm::action::create_an_action(0);
    // // println!("action: {:?}", action);
    // let nonce = 0;
    // let nf_key = NullifierKey::default();
    // let nf_key_cm = nf_key.commit();
    // let mut consumed_resource = Resource {
    //     logic_ref: TrivialLogicWitness::verifying_key(),
    //     nk_commitment: nf_key_cm,
    //     ..Default::default()
    // };
    // consumed_resource.nonce[0] = nonce;
    // let mut created_resource = consumed_resource.clone();
    // created_resource.nonce[10] = nonce;
    //
    // println!("{:?}", INITIAL_ROOT.as_bytes());
    // println!("{:?}", INITIAL_ROOT.as_bytes().to_vec());
    // let bs = <[u8; DIGEST_BYTES]>::from_hex("7e70786b1d52fc0412d75203ef2ac22de13d9596ace8a5a1ed5324c3ed7f31c3");
    // println!("{:?}", bs);
    // let compliance_witness = ComplianceWitness::<COMMITMENT_TREE_DEPTH>::with_fixed_rcv(
    //     consumed_resource.clone(),
    //     nf_key.clone(),
    //     created_resource.clone(),
    // );
    //
    // let compliance_receipt = ComplianceUnit::prove(&compliance_witness);
    //
    // let consumed_resource_nf = consumed_resource.nullifier(&nf_key).unwrap();
    // let created_resource_cm = created_resource.commitment();
    // let action_tree = MerkleTree::new(vec![
    //     consumed_resource_nf.clone().into(),
    //     created_resource_cm.clone().into(),
    // ]);
    // let consumed_resource_path = action_tree.generate_path(&consumed_resource_nf).unwrap();
    // let created_resource_path = action_tree.generate_path(&created_resource_cm).unwrap();
    //
    // let consumed_logic_witness = TrivialLogicWitness::new(
    //     consumed_resource,
    //     consumed_resource_path,
    //     nf_key.clone(),
    //     true,
    // );
    //
    // let consumed_logic_proof = consumed_logic_witness.prove();
    //
    // let created_logic_witness =
    //     TrivialLogicWitness::new(created_resource, created_resource_path, nf_key, false);
    // let created_logic_proof = created_logic_witness.prove();
    //
    // let compliance_units = vec![compliance_receipt];
    // let logic_proofs = vec![consumed_logic_proof, created_logic_proof];
    // let resource_forwarder_calldata_pairs = vec![];
    //
    // let action = Action::new(
    //     compliance_units,
    //     logic_proofs,
    //     resource_forwarder_calldata_pairs,
    // );
    // // assert!(action.verify());
    //
    // let delta_witness = DeltaWitness::from_bytes_vec(&[compliance_witness.rcv]);
    // delta_witness

    let (actions, delta_witness) = create_multiple_actions(10);
    let other_actions = actions.clone();
    // let dw = delta_witness.clone();
    let mut tx = Transaction::new(actions, Delta::Witness(delta_witness));
    tx.generate_delta_proof();
    assert!(tx.verify());

    let mut instances = Vec::new();

    for action in other_actions {
        for compliance_unit in action.compliance_units {
            instances.push((compliance_unit.clone(), compliance_unit.get_instance()));
        }
    }
    tx
}

#[rustler::nif]
fn test_transaction() -> Transaction {
    let (actions, delta_witness) = create_multiple_actions(5);
    let tx = Transaction::new(actions, Delta::Witness(delta_witness));
    tx
}

#[rustler::nif]
fn test_transaction(transaction: Transaction) -> Transaction {
    transaction
}

rustler::init!("Elixir.Anoma.Arm");
