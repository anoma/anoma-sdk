use arm::action_tree::ACTION_TREE_DEPTH;
use arm::logic_proof::{LogicProver, LogicVerifier};
use arm::merkle_path::MerklePath;
use arm::nullifier_key::NullifierKey;
use arm::resource::Resource;
use counter_witness::CounterWitness;
use hex::FromHex;
use risc0_zkvm::Digest;
use rustler::{nif, NifStruct};
use serde::{Deserialize, Serialize};

pub const COUNTER_ELF: &[u8] = include_bytes!("../elf/method.bin");
pub const COUNTER_ID_STRING: &str = include_str!("../elf/id.txt");
pub const COUNTER_ID_STR: &[u8] = include_bytes!("../elf/id.txt");

#[derive(Clone, Default, Deserialize, Serialize, NifStruct)]
#[module = "Anoma.Examples.Counter.CounterLogic"]
pub struct CounterLogic {
    witness: CounterWitness,
}

impl CounterLogic {
    pub fn new(
        is_consumed: bool,
        old_counter: Resource,
        old_counter_existence_path: MerklePath<ACTION_TREE_DEPTH>,
        nf_key: NullifierKey,
        new_counter: Resource,
        new_counter_existence_path: MerklePath<ACTION_TREE_DEPTH>,
    ) -> Self {
        Self {
            witness: CounterWitness {
                is_consumed,
                old_counter,
                old_counter_existence_path,
                nf_key,
                new_counter,
                new_counter_existence_path,
            },
        }
    }
}

impl LogicProver for CounterLogic {
    type Witness = CounterWitness;
    fn proving_key() -> &'static [u8] {
        COUNTER_ELF
    }

    fn verifying_key() -> Digest {
        Digest::from_hex(COUNTER_ID_STRING).unwrap()
    }

    fn witness(&self) -> &Self::Witness {
        &self.witness
    }
}

#[nif]
/// Returns the logic ref for the counter binary.
fn counter_logic_ref() -> Vec<u8> {
    COUNTER_ID_STR.to_vec()
}

#[nif]
/// Given a CounterLogic, returns its LogicProof
pub fn prove_counter_logic(cl: CounterLogic) -> LogicVerifier {
    cl.prove()
}

#[nif]
/// Returns the logic ref for the counter binary.
fn test() -> (Resource, NullifierKey) {
    counter_app::init::ephemeral_counter()
}

rustler::init!("Elixir.Anoma.Examples.Counter");
