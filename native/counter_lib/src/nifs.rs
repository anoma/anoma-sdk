use crate::counter_logic::CounterLogic;
use arm::logic_proof::{LogicProof, LogicProver};

#[rustler::nif]
/// Returns the verifying key digest as bytes.
pub fn counter_logic_ref() -> Vec<u8> {
    CounterLogic::verifying_key_as_bytes()
}

#[rustler::nif]
/// given a CounterLogic, returns its LogicProof
pub fn prove_counter_logic(cl: CounterLogic) -> LogicProof {
    cl.prove()
}
