use crate::counter_logic::CounterLogic;
use crate::proof::generate_counter_logic;
use crate::test::{ephemeral_counter, init_counter_resource};
use counter::CounterWitness;

#[rustler::nif]
/// Creates a CounterWitness and returns it.
pub fn test_counter_witness() -> CounterWitness {
    let (ephemeral_counter, ephemeral_nf_key) = ephemeral_counter();
    let (counter_resource, _counter_nf_key) =
        init_counter_resource(&ephemeral_counter, &ephemeral_nf_key);

    let (consumed_logic, _created_logic) =
        generate_counter_logic(ephemeral_counter, ephemeral_nf_key, counter_resource);
    consumed_logic.witness
}

#[rustler::nif]
/// Returns the CounterWitness passed in as an argument.
pub fn test_counter_witness(cw: CounterWitness) -> CounterWitness {
    cw
}

#[rustler::nif]
/// Returns a CounterLogic struct.
pub fn test_counter_logic() -> CounterLogic {
    let (ephemeral_counter, ephemeral_nf_key) = ephemeral_counter();
    let (counter_resource, _counter_nf_key) =
        init_counter_resource(&ephemeral_counter, &ephemeral_nf_key);

    let (consumed_logic, _created_logic) =
        generate_counter_logic(ephemeral_counter, ephemeral_nf_key, counter_resource);
    consumed_logic
}

#[rustler::nif]
/// Returns the CounterLogic passed in as an argument.
pub fn test_counter_logic(cl: CounterLogic) -> CounterLogic {
    cl
}

