use arm::action_tree::ACTION_TREE_DEPTH;
use arm::logic_proof::LogicProver;
use arm::merkle_path::MerklePath;
use arm::nullifier_key::NullifierKey;
use arm::resource::Resource;
use counter::CounterWitness;
use hex::FromHex;
use lazy_static::lazy_static;
use risc0_zkvm::Digest;
use rustler::NifStruct;
use serde::{Deserialize, Serialize};

pub const SIMPLE_COUNTER_ELF: &[u8] = include_bytes!("../elf/method.bin");
lazy_static! {
    pub static ref SIMPLE_COUNTER_ID: Digest =
        Digest::from_hex("be068dcc59a6d0bd2fc21a945864cee6bbb13d1a0f5741999c2e77e92ecc2766")
            .unwrap();
}

#[derive(Clone, Default, Deserialize, Serialize, NifStruct)]
#[module = "Anoma.Examples.Counter.CounterLogic"]
pub struct CounterLogic {
    pub witness: CounterWitness,
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
        SIMPLE_COUNTER_ELF
    }

    fn verifying_key() -> Digest {
        *SIMPLE_COUNTER_ID
    }

    fn witness(&self) -> &Self::Witness {
        &self.witness
    }
}
