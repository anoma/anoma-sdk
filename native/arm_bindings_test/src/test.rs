//! Implements fucntions to test the NIF functionality and datastructure
//! serialization between Rust and Elixir (or other languages implementing this
//! nif).

use arm::action::Action;
use arm::action_tree::MerkleTree;
use arm::authorization::AuthorizationSignature;
use arm::compliance::{ComplianceInstance, ComplianceWitness};
use arm::compliance_unit::ComplianceUnit;
use arm::delta_proof::{DeltaProof, DeltaWitness};
use arm::encryption::{Ciphertext, SecretKey};
use arm::logic_instance::{AppData, ExpirableBlob};
use arm::logic_proof::{LogicVerifier, LogicVerifierInputs};
use arm::merkle_path::MerklePath;
use arm::nullifier_key::{NullifierKey, NullifierKeyCommitment};
use arm::resource::Resource;
use arm::transaction::{Delta, Transaction};
use k256::ecdsa::{RecoveryId, Signature, SigningKey};
use k256::elliptic_curve::rand_core::OsRng;
use rand::random;
use risc0_zkvm::Digest;
use rustler::nif;

//----------------------------------------------------------------------------//
//                                SecretKey                                   //
//----------------------------------------------------------------------------//

#[nif]
fn test_secret_key() -> SecretKey {
    SecretKey::random()
}

#[nif]
fn test_secret_key(secret_key: SecretKey) -> SecretKey {
    secret_key
}

//----------------------------------------------------------------------------//
//                                Ciphertext                                  //
//----------------------------------------------------------------------------//

#[nif]
fn test_cipher_text() -> Ciphertext {
    Ciphertext::from_words(random_vector_u32(64).as_slice())
}

#[nif]
fn test_cipher_text(cipher_text: Ciphertext) -> Ciphertext {
    cipher_text
}

//----------------------------------------------------------------------------//
//                                Compliance Unit                             //
//----------------------------------------------------------------------------//

#[nif]
/// Create an arbitrary ComplianceUnit and return it.
fn test_compliance_unit() -> ComplianceUnit {
    random_compliance_unit()
}

#[nif]
fn test_compliance_unit(compliance_unit: ComplianceUnit) -> ComplianceUnit {
    compliance_unit
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
    random_logic_verifier_inputs()
}

#[nif]
fn test_logic_verifier_inputs(logic_verifier_inputs: LogicVerifierInputs) -> LogicVerifierInputs {
    logic_verifier_inputs
}

//----------------------------------------------------------------------------//
//                                Action                                      //
//----------------------------------------------------------------------------//

#[nif]
/// Create an arbitrary action and return it.
fn test_action() -> Action {
    random_action()
}

#[nif]
fn test_action(action: Action) -> Action {
    action
}

//----------------------------------------------------------------------------//
//                                Merkle Tree                                 //
//----------------------------------------------------------------------------//

#[nif]
/// Create a default merkle tree.
fn test_merkle_tree() -> MerkleTree {
    MerkleTree::new(vec![random_digest(), random_digest()])
}

#[nif]
fn test_merkle_tree(merkle_tree: MerkleTree) -> MerkleTree {
    merkle_tree
}
//----------------------------------------------------------------------------//
//                                Merkle Path                                 //
//----------------------------------------------------------------------------//

#[nif]
/// Create a default merkle path.
fn test_merkle_path() -> MerklePath {
    random_merkle_path()
}

#[nif]
fn test_merkle_path(merkle_path: MerklePath) -> MerklePath {
    merkle_path
}

//----------------------------------------------------------------------------//
//                                Compliance Instance                         //
//----------------------------------------------------------------------------//

#[nif]
/// Create an arbitrary ComplianceInstance and return it.
fn test_compliance_instance() -> ComplianceInstance {
    random_compliance_instance()
}

#[nif]
/// Return the ComplianceInstance.
fn test_compliance_instance(compliance_instance: ComplianceInstance) -> ComplianceInstance {
    compliance_instance
}

//----------------------------------------------------------------------------//
//                                Compliance Witness                          //
//----------------------------------------------------------------------------//

#[nif]
/// Create an arbitrary compliance witness and return it.
fn test_compliance_witness() -> ComplianceWitness {
    random_compliance_witness()
}

#[nif]
fn test_compliance_witness(compliance_witness: ComplianceWitness) -> ComplianceWitness {
    compliance_witness
}

//----------------------------------------------------------------------------//
//                                Mullifier Key Commitment                    //
//----------------------------------------------------------------------------//

#[nif]
/// Create arbitrary nullifier key commitment and return it.
fn test_nullifier_key_commitment() -> NullifierKeyCommitment {
    random_nullifier_key_commitment()
}

#[nif]
fn test_nullifier_key_commitment(
    nullifier_key_commitment: NullifierKeyCommitment,
) -> NullifierKeyCommitment {
    nullifier_key_commitment
}

//----------------------------------------------------------------------------//
//                                Mullifier Key                               //
//----------------------------------------------------------------------------//

#[nif]
/// Create an arbitrary nullifier key and return it.
fn test_nullifier_key() -> NullifierKey {
    random_nullifier_key()
}

#[nif]
fn test_nullifier_key(nullifier_key: NullifierKey) -> NullifierKey {
    nullifier_key
}

//----------------------------------------------------------------------------//
//                                Resource                                    //
//----------------------------------------------------------------------------//

#[nif]
/// Create an arbitrary resource and return it.
fn test_resource() -> Resource {
    random_resource()
}

#[nif]
fn test_resource(resource: Resource) -> Resource {
    resource
}

//----------------------------------------------------------------------------//
//                                Delta Proof                                 //
//----------------------------------------------------------------------------//

#[nif]
/// Create arbitrary delta proof and return it.
fn test_delta_proof() -> DeltaProof {
    random_delta_proof()
}

#[nif]
fn test_delta_proof(delta_proof: DeltaProof) -> DeltaProof {
    delta_proof
}

//----------------------------------------------------------------------------//
//                                Delta Witness                               //
//----------------------------------------------------------------------------//

#[nif]
/// Create a random delta witness to return from the NIF.
fn test_delta_witness() -> DeltaWitness {
    random_delta_witness()
}

#[nif]
fn test_delta_witness(delta_witness: DeltaWitness) -> DeltaWitness {
    delta_witness
}

//----------------------------------------------------------------------------//
//                                LogicVerifier                               //
//----------------------------------------------------------------------------//

#[nif]
fn test_logic_verifier() -> LogicVerifier {
    random_logic_verifier()
}

#[nif]
fn test_logic_verifier(logic_verifier: LogicVerifier) -> LogicVerifier {
    logic_verifier
}

//----------------------------------------------------------------------------//
//                                Transaction                                 //
//----------------------------------------------------------------------------//

#[nif]
/// Create an arbitrary transaction and return it.
fn test_transaction() -> Transaction {
    random_transaction()
}

#[nif]
fn test_transaction(transaction: Transaction) -> Transaction {
    transaction
}

//----------------------------------------------------------------------------//
//                                Delta                                       //
//----------------------------------------------------------------------------//

#[nif]
/// Create a Delta with a witness.
fn test_delta_with_witness() -> Delta {
    Delta::Witness(random_delta_witness())
}

#[nif]
fn test_delta_with_witness(delta: Delta) -> Delta {
    delta
}

#[nif]
/// Create a Delta with a proof.
fn test_delta_with_proof() -> Delta {
    Delta::Proof(random_delta_proof())
}

#[nif]
fn test_delta_with_proof(delta: Delta) -> Delta {
    delta
}

//

// //----------------------------------------------------------------------------//
// //                                Helpers                                     //
// //----------------------------------------------------------------------------//

fn random_delta() -> Delta {
    if random() {
        Delta::Proof(random_delta_proof())
    } else {
        Delta::Witness(random_delta_witness())
    }
}
fn random_transaction() -> Transaction {
    let actions: Vec<Action> = (0..10).map(|_| random_action()).collect();

    let balance = Some(random_vector_u8(5));
    Transaction {
        actions: actions,
        delta_proof: random_delta(),
        expected_balance: balance,
    }
}

fn random_delta_witness() -> DeltaWitness {
    DeltaWitness {
        signing_key: random_signing_key(),
    }
}
fn random_signing_key() -> SigningKey {
    let mut rng = OsRng;
    let signing_key = SigningKey::random(&mut rng);
    signing_key
}

fn random_signature() -> Signature {
    let auth_sig = AuthorizationSignature::default();
    *auth_sig.inner()
}

fn random_recovery_id() -> RecoveryId {
    RecoveryId::new(random(), random())
}

fn random_delta_proof() -> DeltaProof {
    let sig = random_signature();
    let recovery_id = random_recovery_id();
    DeltaProof {
        signature: sig,
        recid: recovery_id,
    }
}

fn random_merkle_path_node() -> (Vec<u32>, bool) {
    (random_vector_u32(8), random::<bool>())
}

fn random_merkle_path() -> MerklePath {
    let nodes = (0..32).map(|_| random_merkle_path_node()).collect();
    MerklePath(nodes)
}
fn random_digest() -> Digest {
    let bytes = random_vector_u8(32);
    let array: [u8; 32] = bytes.try_into().unwrap();
    Digest::from_bytes(array)
}
fn random_u32() -> u32 {
    random::<u32>()
}
fn random_logic_verifier() -> LogicVerifier {
    LogicVerifier {
        proof: random_vector_u8(32),
        instance: random_vector_u8(32),
        verifying_key: random_vector_u32(32),
    }
}

fn random_nullifier_key() -> NullifierKey {
    let (key, _commitment) = NullifierKey::random_pair();
    key
}

fn random_nullifier_key_commitment() -> NullifierKeyCommitment {
    let (_key, commitment) = NullifierKey::random_pair();
    commitment
}
fn random_resource() -> Resource {
    Resource {
        logic_ref: random_vector_u8(32),
        label_ref: random_vector_u8(32),
        quantity: random(),
        value_ref: random_vector_u8(32),
        is_ephemeral: random(),
        nonce: random_vector_u8(32),
        nk_commitment: random_nullifier_key_commitment(),
        rand_seed: random_vector_u8(32),
    }
}
fn random_compliance_witness() -> ComplianceWitness {
    ComplianceWitness {
        consumed_resource: random_resource(),
        merkle_path: random_merkle_path(),
        ephemeral_root: random_vector_u32(32),
        nf_key: random_nullifier_key(),
        created_resource: random_resource(),
        rcv: random_vector_u8(32),
    }
}

fn random_compliance_instance() -> ComplianceInstance {
    ComplianceInstance {
        consumed_nullifier: random_vector_u32(32),
        consumed_logic_ref: random_vector_u32(32),
        consumed_commitment_tree_root: random_vector_u32(32),
        created_commitment: random_vector_u32(32),
        created_logic_ref: random_vector_u32(32),
        delta_x: random_vector_u32(32),
        delta_y: random_vector_u32(32),
    }
}
fn random_action() -> Action {
    let compliance_units = (0..10).map(|_| random_compliance_unit()).collect();
    let logic_verifier_inputs = (0..10).map(|_| random_logic_verifier_inputs()).collect();
    Action {
        compliance_units,
        logic_verifier_inputs,
    }
}
fn random_compliance_unit() -> ComplianceUnit {
    ComplianceUnit {
        proof: random_vector_u8(32),
        instance: random_vector_u8(32),
    }
}

fn random_logic_verifier_inputs() -> LogicVerifierInputs {
    LogicVerifierInputs {
        tag: random_vector_u32(32),
        verifying_key: random_vector_u32(32),
        app_data: random_app_data(),
        proof: random_vector_u8(32),
    }
}
fn random_vector_u32(length: u32) -> Vec<u32> {
    (0..length).map(|_| random::<u32>()).collect()
}

fn random_vector_u8(length: u32) -> Vec<u8> {
    (0..length).map(|_| random::<u8>()).collect()
}

fn random_epxirable_blob() -> ExpirableBlob {
    let expirable_blob = ExpirableBlob {
        // blob: random_vector_u32(32),
        blob: vec![1, 2, 3, 512, 512, 514, 128],
        deletion_criterion: random_u32(),
    };
    expirable_blob
}

fn random_app_data() -> AppData {
    AppData {
        resource_payload: vec![random_epxirable_blob(), random_epxirable_blob()],
        discovery_payload: vec![random_epxirable_blob(), random_epxirable_blob()],
        external_payload: vec![random_epxirable_blob(), random_epxirable_blob()],
        application_payload: vec![random_epxirable_blob(), random_epxirable_blob()],
    }
}
