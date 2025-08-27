use arm::compliance::ComplianceWitness;
use arm::compliance_unit::ComplianceUnit;
use arm::logic_proof::{LogicProver, LogicVerifier};
use arm::merkle_path::COMMITMENT_TREE_DEPTH;
use counter_app::CounterLogic;
use rustler::nif;

#[nif]
/// Generate a compliance unit from a compliance witness.
fn prove(compliance_witness: ComplianceWitness<COMMITMENT_TREE_DEPTH>) -> ComplianceUnit {
    ComplianceUnit::create(&compliance_witness)
}



rustler::init!("Elixir.Anoma.Arm");
