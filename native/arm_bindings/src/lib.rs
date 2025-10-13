use arm::compliance::ComplianceInstance;
use arm::compliance::ComplianceWitness;
use arm::compliance_unit::ComplianceUnit;
use arm::delta_proof::DeltaProof;
use arm::delta_proof::DeltaWitness;
use arm::encryption::{random_keypair, Ciphertext, SecretKey};
use arm::logic_proof::LogicVerifier;
use arm::logic_proof::LogicVerifierInputs;
use arm::transaction::Transaction;
use k256::AffinePoint;
use rustler::{nif, SerdeTerm};
use serde::{Deserialize, Serialize};

/// A Keypair is a struct that holds a SecretKey and Affinepoint.
/// It is used here to implement the Encoder and RusterEncoder trait.
/// The encoded value is a tuple.
#[derive(Deserialize, Serialize)]
#[serde(rename = "Elixir.AnomaSDK.Arm.Keypair")]
pub struct Keypair {
    #[serde(rename = "secret_key")]
    pub secret: SecretKey,
    #[serde(rename = "public_key")]
    pub public: AffinePoint,
}

#[nif]
/// Generates a random pair of SecretKey and AffinePoint.
pub fn random_key_pair() -> SerdeTerm<Keypair> {
    let (secret, public) = random_keypair();
    SerdeTerm(Keypair { secret, public })
}

/// Returns the ComplianceInstance from within a ComplianceUnit
#[nif]
fn compliance_unit_instance(SerdeTerm(unit): SerdeTerm<ComplianceUnit>) -> SerdeTerm<ComplianceInstance> {
    SerdeTerm(unit.get_instance())
}

#[nif]
fn encrypt_cipher(SerdeTerm(cipher): SerdeTerm<Vec<u8>>, SerdeTerm(keypair): SerdeTerm<Keypair>, SerdeTerm(nonce): SerdeTerm<Vec<u8>>) -> SerdeTerm<Ciphertext> {
    SerdeTerm(Ciphertext::encrypt(
        cipher.as_ref(),
        &keypair.public,
        &keypair.secret,
        nonce.try_into().expect("REASON"),
    ))
}

#[nif]
pub fn decrypt_cipher(SerdeTerm(cipher_bytes): SerdeTerm<Vec<u8>>, SerdeTerm(keypair): SerdeTerm<Keypair>) -> SerdeTerm<Option<Vec<u8>>> {
    let cipher_text = Ciphertext::from_bytes(cipher_bytes);
    let decipher_result = cipher_text.decrypt(&keypair.secret);
    SerdeTerm(decipher_result.ok())
}

#[nif]
/// Generate a compliance unit from a compliance witness.
fn prove_compliance_witness(SerdeTerm(compliance_witness): SerdeTerm<ComplianceWitness>) -> SerdeTerm<ComplianceUnit> {
    SerdeTerm(ComplianceUnit::create(&compliance_witness))
}

#[nif]
/// Converts a logic verifier to a logic verifier inputs.
/// this nif is here because this conversion relies on the Journal
/// implementation of Risc0 ZKVM.
fn convert(SerdeTerm(logic_verifier): SerdeTerm<LogicVerifier>) -> SerdeTerm<LogicVerifierInputs> {
    SerdeTerm(logic_verifier.into())
}

#[nif]
/// Generate a proof for a delta witness.
fn prove_delta_witness(SerdeTerm(witness): SerdeTerm<DeltaWitness>, SerdeTerm(message): SerdeTerm<Vec<u8>>) -> SerdeTerm<DeltaProof> {
    SerdeTerm(DeltaProof::prove(&message, &witness))
}

#[nif]
/// Given a transaction, puts in the delta proof.
pub fn generate_delta_proof(SerdeTerm(transaction): SerdeTerm<Transaction>) -> SerdeTerm<Transaction> {
    let mut tx = transaction.clone();
    tx.generate_delta_proof();
    SerdeTerm(tx)
}

#[nif]
pub fn verify_transaction(SerdeTerm(transaction): SerdeTerm<Transaction>) -> SerdeTerm<bool> {
    SerdeTerm(transaction.verify())
}

rustler::init!("Elixir.AnomaSDK.Arm");
