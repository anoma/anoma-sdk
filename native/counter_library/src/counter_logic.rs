use arm::action_tree::ACTION_TREE_DEPTH;
use arm::logic_proof::LogicProver;
use arm::merkle_path::MerklePath;
use arm::nullifier_key::NullifierKey;
use arm::resource::Resource;
use counter_witness::CounterWitness;
use hex::FromHex;
use lazy_static::lazy_static;
use risc0_zkvm::Digest;
use serde::{Deserialize, Serialize};

#[cfg(feature = "nif")]
use rustler::NifStruct;
pub const SIMPLE_COUNTER_ELF: &[u8] = include_bytes!("../elf/counter_guest.bin");
lazy_static! {
    pub static ref SIMPLE_COUNTER_ID: Digest =
        Digest::from_hex("575ad0ac0274f5685e5d7063dd33f6588bef1819566db40a93425bd338ef5ec1")
            .unwrap();
}

#[derive(Clone, Default, Deserialize, Serialize)]
#[cfg_attr(feature = "nif", derive(NifStruct))]
#[cfg_attr(feature = "nif", module = "Anoma.Examples.Counter.CounterLogic")]
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
        SIMPLE_COUNTER_ELF
    }

    fn verifying_key() -> Digest {
        *SIMPLE_COUNTER_ID
    }

    fn witness(&self) -> &Self::Witness {
        &self.witness
    }
}
