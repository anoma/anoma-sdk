// This file contains the structs that are required as inputs for the logic circuit.


pub use arm::resource_logic::LogicCircuit;
use arm::{
    action_tree::ACTION_TREE_DEPTH, logic_instance::LogicInstance, merkle_path::MerklePath,
    nullifier_key::NullifierKey, resource::Resource,
};
use serde::{Deserialize, Serialize};
#[derive(Clone, Default, Serialize, Deserialize)]
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
        // Load resources
        let old_nf = self.old_counter.nullifier(&self.nf_key).unwrap();
        let new_cm = self.new_counter.commitment();

        // Check existence paths
        let old_counter_root = self.old_counter_existence_path.root(&old_nf);
        let new_counter_root = self.new_counter_existence_path.root(&new_cm);
        assert_eq!(old_counter_root, new_counter_root);

        assert_eq!(self.old_counter.quantity, 1);
        assert_eq!(self.new_counter.quantity, 1);

        let old_counter_value: u128 =
            u128::from_le_bytes(self.old_counter.value_ref[0..16].try_into().unwrap());
        let new_counter_value: u128 =
            u128::from_le_bytes(self.new_counter.value_ref[0..16].try_into().unwrap());

        // Init a new counter resource with the value 1
        if self.old_counter.is_ephemeral {
            assert_eq!(new_counter_value, 1);
        }

        // Check that the new counter value is one more than the old counter value
        assert_eq!(new_counter_value, old_counter_value + 1);

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

// use arm::action_tree::MerkleTree;
// use arm::compliance_unit::ComplianceUnit;
// use arm::logic_proof::{LogicProof, LogicProver};
// pub use arm::resource_logic::LogicCircuit;
// use arm::{
//     action_tree::ACTION_TREE_DEPTH, compliance::ComplianceWitness,
//     merkle_path::MerklePath, merkle_path::COMMITMENT_TREE_DEPTH, nullifier_key::NullifierKey,
//     resource::Resource,
// };
// use methods::{METHOD_ELF, METHOD_ID};
// use rand::Rng;
// use serde::{Deserialize, Serialize};
// use risc0_zkvm::Digest;
//
// //----------------------------------------------------------------------------//
// //                                Structs                                     //
// //----------------------------------------------------------------------------//
//
// #[derive(Clone, Default, Deserialize, Serialize, rustler::NifStruct)]
// #[module = "Anoma.Examples.Counter.CounterLogic"]
// pub struct CounterLogic {
//     witness: CounterWitness,
// }
//
// impl CounterLogic {
//     pub fn new(
//         is_consumed: bool,
//         old_counter: Resource,
//         old_counter_existence_path: MerklePath<ACTION_TREE_DEPTH>,
//         nf_key: NullifierKey,
//         new_counter: Resource,
//         new_counter_existence_path: MerklePath<ACTION_TREE_DEPTH>,
//     ) -> Self {
//         Self {
//             witness: CounterWitness {
//                 is_consumed,
//                 old_counter,
//                 old_counter_existence_path,
//                 nf_key,
//                 new_counter,
//                 new_counter_existence_path,
//             },
//         }
//     }
// }
//
// impl LogicProver for CounterLogic {
//     type Witness = CounterWitness;
//     fn proving_key() -> &'static [u8] {
//         METHOD_ELF
//     }
//
//     fn verifying_key() -> Digest {
//         *METHOD_ID
//     }
//
//     fn witness(&self) -> &Self::Witness {
//         &self.witness
//     }
// }
//
// #[derive(Clone, Default, Serialize, Deserialize, rustler::NifStruct)]
// #[module = "Anoma.Examples.Counter.CounterWitness"]
// pub struct CounterWitness {
//     pub is_consumed: bool,
//     pub old_counter: Resource,
//     pub old_counter_existence_path: MerklePath<ACTION_TREE_DEPTH>,
//     pub nf_key: NullifierKey,
//     pub new_counter: Resource,
//     pub new_counter_existence_path: MerklePath<ACTION_TREE_DEPTH>,
// }
//
// //----------------------------------------------------------------------------//
// //                                Helper Functions                            //
// //----------------------------------------------------------------------------//
//
// pub fn convert_counter_to_value_ref(value: u128) -> Vec<u8> {
//     let mut arr = [0u8; 32];
//     let bytes = value.to_le_bytes();
//     arr[..16].copy_from_slice(&bytes); // left-align, right-pad with 0
//     arr.to_vec()
// }
//
// pub fn convert_image_id_to_bytes(id: &[u32]) -> Vec<u8> {
//     let mut bytes = Vec::with_capacity(id.len() * 4);
//     for &word in id {
//         bytes.extend_from_slice(&word.to_le_bytes());
//     }
//     bytes
// }
//
// pub fn counter_logic_ref() -> Vec<u8> {
//     let mut bytes = Vec::with_capacity(METHOD_ID.len() * 4);
//     for &word in &METHOD_ID {
//         bytes.extend_from_slice(&word.to_le_bytes());
//     }
//     bytes
// }
//
// pub fn init_counter_resource() -> (Resource, NullifierKey) {
//     let mut rng = rand::thread_rng();
//     let (nf_key, nf_key_cm) = NullifierKey::random_pair();
//     let label_ref: [u8; 32] = rng.r#gen(); // Random label reference, it should be unique for each counter_logic_circuit
//     let counter_resource = Resource::create(
//         counter_logic_ref(),
//         label_ref.to_vec(),
//         1,
//         convert_counter_to_value_ref(1u128), // Initialize with value/counter_logic_circuit 1
//         false,
//         nf_key_cm,
//     );
//     (counter_resource, nf_key)
// }
//
// pub fn ephemeral_counter(inited_counter: &Resource) -> (Resource, NullifierKey) {
//     let (nf_key, nf_key_cm) = NullifierKey::random_pair();
//     let mut ephemeral_counter = inited_counter.clone();
//     ephemeral_counter.is_ephemeral = true;
//     ephemeral_counter.reset_randomness_nonce();
//     ephemeral_counter.set_value_ref(convert_counter_to_value_ref(0u128));
//     ephemeral_counter.set_nf_commitment(nf_key_cm.clone());
//     (ephemeral_counter, nf_key)
// }
//
// pub fn generate_compliance_proof(
//     consumed_counter: Resource,
//     nf_key: NullifierKey,
//     merkle_path: MerklePath<COMMITMENT_TREE_DEPTH>,
//     created_counter: Resource,
// ) -> (ComplianceUnit, Vec<u8>) {
//     let compliance_witness = ComplianceWitness::<COMMITMENT_TREE_DEPTH>::from_resources_with_path(
//         consumed_counter,
//         nf_key,
//         merkle_path,
//         created_counter,
//     );
//     let compliance_unit = ComplianceUnit::prove(&compliance_witness);
//     (compliance_unit, compliance_witness.rcv)
// }
//
// pub fn generate_logic_proofs(
//     consumed_counter: Resource,
//     nf_key: NullifierKey,
//     created_counter: Resource,
// ) -> Vec<LogicProof> {
//     let consumed_counter_nf = consumed_counter.nullifier(&nf_key).unwrap();
//     let created_counter_cm = created_counter.commitment();
//
//     let action_tree = MerkleTree::new(vec![
//         consumed_counter_nf.clone().into(),
//         created_counter_cm.clone().into(),
//     ]);
//
//     let consumed_counter_path = action_tree.generate_path(&consumed_counter_nf).unwrap();
//     let created_counter_path = action_tree.generate_path(&created_counter_cm).unwrap();
//
//     let consumed_counter_logic = CounterLogic::new(
//         true,
//         consumed_counter.clone(),
//         consumed_counter_path.clone(),
//         nf_key.clone(),
//         created_counter.clone(),
//         created_counter_path.clone(),
//     );
//     let consumed_logic_proof = consumed_counter_logic.prove();
//
//     let created_counter_logic = CounterLogic::new(
//         false,
//         consumed_counter,
//         consumed_counter_path,
//         nf_key,
//         created_counter,
//         created_counter_path,
//     );
//     let created_logic_proof = created_counter_logic.prove();
//
//     vec![consumed_logic_proof, created_logic_proof]
// }
//
// //----------------------------------------------------------------------------//
// //                                Public Functions                            //
// //----------------------------------------------------------------------------//
//
// #[rustler::nif]
// pub fn counter_logic_ref() -> Vec<u8> {
//     let mut bytes = Vec::with_capacity(METHOD_ID.len() * 4);
//     for &word in &METHOD_ID {
//         bytes.extend_from_slice(&word.to_le_bytes());
//     }
//     bytes
// }
//
// #[rustler::nif]
// pub fn prove_counter_logic(counter_logic: CounterLogic) -> LogicProof {
//     counter_logic.prove()
// }
//
// //----------------------------------------------------------------------------//
// //                               Testing Functions                            //
// //----------------------------------------------------------------------------//
//
// #[rustler::nif]
// fn test_counter_witness() -> CounterWitness {
//     let (counter_resource, nf_key) = init_counter_resource();
//     let (ephemeral_counter, ephemeral_nf_key) = ephemeral_counter(&counter_resource);
//     let consumed_counter_nf = ephemeral_counter.nullifier(&ephemeral_nf_key).unwrap();
//     let created_counter_cm = counter_resource.commitment();
//
//     let action_tree = MerkleTree::new(vec![
//         consumed_counter_nf.clone().into(),
//         created_counter_cm.clone().into(),
//     ]);
//
//     let consumed_counter_path = action_tree.generate_path(&consumed_counter_nf).unwrap();
//     let created_counter_path = action_tree.generate_path(&created_counter_cm).unwrap();
//
//     let consumed_counter_logic: CounterLogic = CounterLogic::new(
//         true,
//         ephemeral_counter.clone(),
//         consumed_counter_path.clone(),
//         nf_key.clone(),
//         counter_resource.clone(),
//         created_counter_path.clone(),
//     );
//
//     consumed_counter_logic.witness
// }
//
// #[rustler::nif]
// fn test_counter_witness(cw: CounterWitness) -> CounterWitness {
//     cw
// }
//
// #[rustler::nif]
// fn test_counter_logic() -> CounterLogic {
//     let (counter_resource, nf_key) = init_counter_resource();
//     let (ephemeral_counter, ephemeral_nf_key) = ephemeral_counter(&counter_resource);
//     let consumed_counter_nf = ephemeral_counter.nullifier(&ephemeral_nf_key).unwrap();
//     let created_counter_cm = counter_resource.commitment();
//
//     let action_tree = MerkleTree::new(vec![
//         consumed_counter_nf.clone().into(),
//         created_counter_cm.clone().into(),
//     ]);
//
//     let consumed_counter_path = action_tree.generate_path(&consumed_counter_nf).unwrap();
//     let created_counter_path = action_tree.generate_path(&created_counter_cm).unwrap();
//
//     let consumed_counter_logic: CounterLogic = CounterLogic::new(
//         true,
//         ephemeral_counter.clone(),
//         consumed_counter_path.clone(),
//         nf_key.clone(),
//         counter_resource.clone(),
//         created_counter_path.clone(),
//     );
//
//     consumed_counter_logic
// }
//
// #[rustler::nif]
// fn test_counter_logic(cl: CounterLogic) -> CounterLogic {
//     cl
// }
//
// rustler::init!("Elixir.Anoma.Examples.Counter");
