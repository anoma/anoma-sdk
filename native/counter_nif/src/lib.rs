mod test;
mod eth;
mod transaction;

use arm::compliance::ComplianceInstance;
use arm::compliance_unit::ComplianceUnit;
use arm::logic_proof::LogicVerifier;
use arm::nullifier_key::{NullifierKey, NullifierKeyCommitment};
use arm::resource::Resource;
use arm::transaction::Transaction;
use counter_library::counter_logic::CounterLogic;


#[rustler::nif]
/// Returns the logic ref for the counter binary.
pub fn counter_logic_ref() -> Vec<u8> {
    test::counter_logic_ref()
}

#[rustler::nif]
/// Given a CounterLogic, returns its LogicProof
pub fn prove_counter_logic(counter_logic: CounterLogic) -> LogicVerifier {
    test::prove_counter_logic(counter_logic)
}

#[rustler::nif]
/// Returns the logic ref for the counter binary.
pub fn submit_transaction(transaction: arm::transaction::Transaction) {
    test::submit_transaction(transaction)
}

#[rustler::nif]
pub fn keypair() -> (
    (NullifierKey, NullifierKeyCommitment),
    (NullifierKey, NullifierKeyCommitment),
) {
    let x = NullifierKey::random_pair();
    let y = NullifierKey::random_pair();
    (x, y)
}

#[rustler::nif]
pub fn create_tx_in_rust(
    a: (NullifierKey, NullifierKeyCommitment),
    b: (NullifierKey, NullifierKeyCommitment),
) -> (
    Transaction,
    Resource,
    NullifierKey,
    ComplianceUnit,
    ComplianceInstance,
) {
    test::create_tx_in_rust(a, b)
}

#[rustler::nif]
pub fn delta_message(transaction : Transaction) -> Vec<u8> {
    test::delta_message(transaction)
}


rustler::init!("Elixir.Anoma.Examples.Counter");
