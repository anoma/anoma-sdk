/*
This module defines the data structures that holds the data that a proof is created over.

When running the ZKVM proof generator, the witness is the input for the program that runs and is
being traced.

Here the counter witness contains information about:

 - Is the counter consumed
 - What is the old counter
 - What is the new counter
 - The nullifier key

 */
pub use arm::resource_logic::LogicCircuit;
use arm::{
    action_tree::ACTION_TREE_DEPTH, logic_instance::LogicInstance, merkle_path::MerklePath,
    nullifier_key::NullifierKey, resource::Resource,
};
use rustler::NifStruct;
use serde::{Deserialize, Serialize};
#[derive(Clone, Default, Serialize, Deserialize, NifStruct)]
#[module = "Anoma.Examples.Counter.CounterWitness"]
pub struct CounterWitness {
    pub is_consumed: bool,
    pub old_counter: Resource,
    pub old_counter_existence_path: MerklePath<ACTION_TREE_DEPTH>,
    pub nf_key: NullifierKey,
    pub new_counter: Resource,
    pub new_counter_existence_path: MerklePath<ACTION_TREE_DEPTH>,
}

impl LogicCircuit for CounterWitness {
    fn constrain(&self) -> LogicInstance {
        println!("here1");
        // Load resources
        let old_nf = self.old_counter.nullifier(&self.nf_key).unwrap();
        println!("here2");
        let new_cm = self.new_counter.commitment();
        println!("here3");
        // Check existence paths
        let old_counter_root = self.old_counter_existence_path.root(&old_nf);
        let new_counter_root = self.new_counter_existence_path.root(&new_cm);
        println!("here");
        assert_eq!(
            old_counter_root, new_counter_root,
            "old counter and new counter must have the same root"
        );

        assert_eq!(
            self.old_counter.quantity, 1,
            "old counter quantity must be 1"
        );
        assert_eq!(
            self.new_counter.quantity, 1,
            "new conter quantity must be 1"
        );

        let old_counter_value: u128 =
            u128::from_le_bytes(self.old_counter.value_ref[0..16].try_into().unwrap());
        let new_counter_value: u128 =
            u128::from_le_bytes(self.new_counter.value_ref[0..16].try_into().unwrap());

        // Init a new counter resource with the value 1
        if self.old_counter.is_ephemeral {
            assert_eq!(
                new_counter_value, 1,
                "the new counter value must be 1 if the old counter is ephemeral"
            );
        }

        // Check that the new counter value is one more than the old counter value
        assert_eq!(
            new_counter_value,
            old_counter_value + 1,
            "the new counter value must be 1 more than the old counter"
        );

        let tag = if self.is_consumed { old_nf } else { new_cm };

        LogicInstance {
            tag,
            is_consumed: self.is_consumed,
            root: old_counter_root,
            cipher: vec![],
            app_data: vec![],
        }
    }
}
