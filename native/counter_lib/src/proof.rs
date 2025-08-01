use crate::counter_logic::CounterLogic;
use arm::action_tree::MerkleTree;
use arm::compliance::ComplianceWitness;
use arm::compliance_unit::ComplianceUnit;
use arm::logic_proof::{LogicProof, LogicProver};
use arm::merkle_path::{MerklePath, COMMITMENT_TREE_DEPTH};
use arm::nullifier_key::NullifierKey;
use arm::resource::Resource;

/// Given a consumed counter and a created counter, returns the compliance witness.
pub fn generate_compliance_witness(
    consumed_counter: Resource,
    nf_key: NullifierKey,
    merkle_path: MerklePath<COMMITMENT_TREE_DEPTH>,
    created_counter: Resource,
) -> ComplianceWitness<COMMITMENT_TREE_DEPTH> {
    let compliance_witness = ComplianceWitness::<COMMITMENT_TREE_DEPTH>::from_resources_with_path(
        consumed_counter,
        nf_key,
        merkle_path,
        created_counter,
    );
    compliance_witness
}
/// Given a consumed counter and a created counter, creates a compliance proof.
pub fn generate_compliance_proof(
    consumed_counter: Resource,
    nf_key: NullifierKey,
    merkle_path: MerklePath<COMMITMENT_TREE_DEPTH>,
    created_counter: Resource,
) -> (ComplianceUnit, Vec<u8>) {
    let compliance_witness =
        generate_compliance_witness(consumed_counter, nf_key, merkle_path, created_counter);
    let compliance_unit = ComplianceUnit::create(&compliance_witness);
    (compliance_unit, compliance_witness.rcv)
}

/// Generate the CounterLogic for a given consumed and created counter.
pub fn generate_counter_logic(
    consumed_counter: Resource,
    nf_key: NullifierKey,
    created_counter: Resource,
) -> (CounterLogic, CounterLogic) {
    let consumed_counter_nf = consumed_counter.nullifier(&nf_key).unwrap();
    let created_counter_cm = created_counter.commitment();

    let action_tree = MerkleTree::new(vec![
        consumed_counter_nf.clone().into(),
        created_counter_cm.clone().into(),
    ]);

    let consumed_counter_path = action_tree.generate_path(&consumed_counter_nf).unwrap();
    let created_counter_path = action_tree.generate_path(&created_counter_cm).unwrap();

    let consumed_counter_logic = CounterLogic::new(
        true,
        consumed_counter.clone(),
        consumed_counter_path.clone(),
        nf_key.clone(),
        created_counter.clone(),
        created_counter_path.clone(),
    );

    let created_counter_logic = CounterLogic::new(
        false,
        consumed_counter,
        consumed_counter_path,
        nf_key,
        created_counter,
        created_counter_path,
    );

    (consumed_counter_logic, created_counter_logic)
}
/// Generate a logic proof for a consumed and created counter.
pub fn generate_logic_proofs(
    consumed_counter: Resource,
    nf_key: NullifierKey,
    created_counter: Resource,
) -> Vec<LogicProof> {
    let (consumed_counter_logic, created_counter_logic) =
        generate_counter_logic(consumed_counter, nf_key, created_counter);

    let consumed_logic_proof = consumed_counter_logic.prove();
    let created_logic_proof = created_counter_logic.prove();

    vec![consumed_logic_proof, created_logic_proof]
}
