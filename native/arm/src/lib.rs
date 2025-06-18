use arm::compliance::ComplianceInstance;
use arm::transaction::Transaction;
use arm::compliance::ComplianceWitness;
use arm::compliance_unit::ComplianceUnit;
use arm::delta_proof::DeltaProof;
use arm::delta_proof::DeltaWitness;
use rustler::nif;
use arm::logic_proof::{LogicVerifier, LogicVerifierInputs};

#[nif]
/// Generate a compliance unit from a compliance witness.
fn prove(compliance_witness: ComplianceWitness) -> ComplianceUnit {
    ComplianceUnit::create(&compliance_witness)
}

#[nif]
//// Converts a ComplianceUnit into a ComplianceInstance.
fn unit_instance(unit: ComplianceUnit) -> ComplianceInstance {
    unit.get_instance()
}

#[nif]
/// Generate a proof for a delta witness.
fn prove_delta_witness(witness: DeltaWitness, message: Vec<u8>) -> DeltaProof {
    let proof = DeltaProof::prove(&message, &witness);
    proof
}

#[nif]
/// Converts a logic verifier to a logic verifier inputs.
/// this nif is here because this conversion relies on the Journal
/// implementation of Risc0 ZKVM.
fn convert(logic_verifier : LogicVerifier) -> LogicVerifierInputs {
    logic_verifier.into()
}

#[nif]
/// Given a transaction, puts in the delta proof.
pub fn generate_delta_proof(transaction: Transaction) -> Transaction {
    let mut tx = transaction.clone();
    tx.generate_delta_proof();
    tx
}

#[nif]
/// Generates a random pair of SecretKey and AffinePoint.
pub fn random_key_pair() -> (SecretKey, Vec<u8>) {
    let (key, point) = arm::encryption::random_keypair();
    (key, counter_witness::encode_affine_point(point))
}


rustler::init!("Elixir.Anoma.Arm");
