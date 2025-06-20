//----------------------------------------------------------------------------//
//                                Delta Witness                               //
//----------------------------------------------------------------------------//

use aarm::action::{create_multiple_actions, ForwarderCalldata};
use aarm_core::delta_proof::DeltaWitness;
use k256::ecdsa::SigningKey;
use std::env;

#[rustler::nif]
fn test_delta_witness() -> DeltaWitness {
    // create a random delta witness
    use k256::ecdsa::SigningKey;
    use k256::elliptic_curve::rand_core::OsRng;

    let mut rng = OsRng;
    let signing_key = SigningKey::random(&mut rng);

    DeltaWitness {
        signing_key: signing_key,
    }
}

#[rustler::nif]
fn test_delta_witness(delta_witness: DeltaWitness) -> DeltaWitness {
    delta_witness
}

//----------------------------------------------------------------------------//
//                                Delta Proof                                 //
//----------------------------------------------------------------------------//

use aarm_core::delta_proof::DeltaProof;
#[rustler::nif]
fn test_delta_proof() -> DeltaProof {
    use k256::elliptic_curve::rand_core::OsRng;

    let mut rng = OsRng;
    let signing_key = SigningKey::random(&mut rng);
    let message = b"Hello, world!";
    let witness = DeltaWitness { signing_key };
    DeltaProof::prove(message, &witness)
}

#[rustler::nif]
fn test_delta_proof(delta_proof: DeltaProof) -> DeltaProof {
    delta_proof
}

//----------------------------------------------------------------------------//
//                                Delta                                       //
//----------------------------------------------------------------------------//

use aarm::transaction::{Delta, Transaction};

#[rustler::nif]
fn test_delta_with_witness() -> Delta {
    // create a random delta witness
    use k256::ecdsa::SigningKey;
    use k256::elliptic_curve::rand_core::OsRng;

    let mut rng = OsRng;
    let signing_key = SigningKey::random(&mut rng);

    let dw: DeltaWitness = DeltaWitness {
        signing_key: signing_key,
    };

    Delta::Witness(dw)
}

#[rustler::nif]
fn test_delta_with_proof() -> Delta {
    use k256::elliptic_curve::rand_core::OsRng;

    let mut rng = OsRng;
    let signing_key = SigningKey::random(&mut rng);
    let message = b"Hello, world!";
    let witness = DeltaWitness { signing_key };
    let dp = DeltaProof::prove(message, &witness);
    Delta::Proof(dp)
}

//----------------------------------------------------------------------------//
//                                Compliance Unit                             //
//----------------------------------------------------------------------------//

use aarm_core::constants::COMMITMENT_TREE_DEPTH;

#[rustler::nif]
fn test_compliance_unit() -> ComplianceUnit {
    let nonce = 1;
    let nf_key = NullifierKey::default();
    let nf_key_cm = nf_key.commit();
    let mut consumed_resource = Resource {
        logic_ref: TrivialLogicWitness::verifying_key(),
        nk_commitment: nf_key_cm,
        ..Default::default()
    };
    consumed_resource.nonce[0] = nonce;
    let mut created_resource = consumed_resource.clone();
    created_resource.nonce[10] = nonce;

    let compliance_witness = ComplianceWitness::<COMMITMENT_TREE_DEPTH>::with_fixed_rcv(
        consumed_resource.clone(),
        nf_key.clone(),
        created_resource.clone(),
    );
    let compliance_receipt = ComplianceUnit::prove(&compliance_witness);
    compliance_receipt
}
#[rustler::nif]
fn test_compliance_unit(compliance_unit: ComplianceUnit) -> ComplianceUnit {
    compliance_unit
}

//----------------------------------------------------------------------------//
//                                Logic Proof                                 //
//----------------------------------------------------------------------------//

#[rustler::nif]
fn test_logic_proof() -> LogicProof {
    let key = "RISC0_DEV_MODE";
    match env::var(key) {
        Ok(val) => println!("{key}: {val:?}"),
        Err(e) => println!("couldn't interpret {key}: {e}"),
    }

    let nonce = 1;

    // LogicProof{
    //     instance: vec![42, 127, 203, 15, 89, 254, 33, 178, 91, 6],
    //     proof: vec![42, 127, 203, 15, 89, 254, 33, 178, 91, 7],
    //     verifying_key: vec![42, 127, 203, 15, 89, 254, 33, 178, 91, 8],
    // }
    let nf_key = NullifierKey::default();
    let nf_key_cm = nf_key.commit();
    let mut consumed_resource = Resource {
        logic_ref: TrivialLogicWitness::verifying_key(),
        nk_commitment: nf_key_cm,
        ..Default::default()
    };
    consumed_resource.nonce[0] = nonce;
    let mut created_resource = consumed_resource.clone();
    created_resource.nonce[10] = nonce;

    let consumed_resource_nf = consumed_resource.nullifier(&nf_key).unwrap();
    let created_resource_cm = created_resource.commitment();
    let action_tree = MerkleTree::new(vec![
        consumed_resource_nf.clone().into(),
        created_resource_cm.clone().into(),
    ]);
    let consumed_resource_path = action_tree.generate_path(&consumed_resource_nf).unwrap();

    let consumed_logic_witness = TrivialLogicWitness::new(
        consumed_resource,
        consumed_resource_path,
        nf_key.clone(),
        true,
    );
    let consumed_logic_proof = consumed_logic_witness.prove();
    consumed_logic_proof
}

#[rustler::nif]
fn test_logic_proof(logic_proof: LogicProof) -> LogicProof {
    logic_proof
}

//----------------------------------------------------------------------------//
//                                Resource                                    //
//----------------------------------------------------------------------------//

#[rustler::nif]
fn test_resource() -> Resource {
    let nf_key = NullifierKey::default();
    let nf_key_cm = nf_key.commit();
    let consumed_resource = Resource {
        logic_ref: TrivialLogicWitness::verifying_key(),
        nk_commitment: nf_key_cm,
        ..Default::default()
    };
    consumed_resource
}

#[rustler::nif]
fn test_resource(resource: Resource) -> Resource {
    resource
}

//----------------------------------------------------------------------------//
//                                Forwarder Calldata                          //
//----------------------------------------------------------------------------//

#[rustler::nif]
fn test_forwarder_calldata() -> ForwarderCalldata {
    ForwarderCalldata {
        untrusted_forwarder: [0u8; 20],
        input: vec![],
        output: vec![],
    }
}

#[rustler::nif]
fn test_forwarder_calldata(forwarder_calldata: ForwarderCalldata) -> ForwarderCalldata {
    forwarder_calldata
}

//----------------------------------------------------------------------------//
//                                Action                                      //
//----------------------------------------------------------------------------//
use aarm::action::Action;
use aarm::compliance_unit::ComplianceUnit;
use aarm::logic_proof::{LogicProof, LogicProver};
use aarm_core::action_tree::MerkleTree;
use aarm_core::compliance::ComplianceWitness;
use aarm_core::nullifier_key::{NullifierKey, NullifierKeyCommitment};
use aarm_core::resource::Resource;
use aarm_core::resource_logic::TrivialLogicWitness;

#[rustler::nif]
fn test_action() -> Action {
    Action::new(vec![], vec![], vec![])
}

#[rustler::nif]
fn test_action(action: Action) -> Action {
    action
}

//----------------------------------------------------------------------------//
//                                Mullifier Key                               //
//----------------------------------------------------------------------------//

#[rustler::nif]
fn test_nullifier_key() -> NullifierKey {
    let (nullifier_key, _) = NullifierKey::random_pair();
    nullifier_key
}

#[rustler::nif]
fn test_nullifier_key(nullifier_key: NullifierKey) -> NullifierKey {
    nullifier_key
}

//----------------------------------------------------------------------------//
//                                Mullifier Key Commitment                    //
//----------------------------------------------------------------------------//

#[rustler::nif]
fn test_nullifier_key_commitment() -> NullifierKeyCommitment {
    let (_, test_nullifier_key_commitment) = NullifierKey::random_pair();
    test_nullifier_key_commitment
}

#[rustler::nif]
fn test_nullifier_key_commitment(
    nullifier_key_commitment: NullifierKeyCommitment,
) -> NullifierKeyCommitment {
    nullifier_key_commitment
}

//----------------------------------------------------------------------------//
//                                Transaction                                 //
//----------------------------------------------------------------------------//

#[rustler::nif]
fn test_transaction() -> Transaction {
    let (actions, delta_witness) = create_multiple_actions(5);
    let tx = Transaction::new(actions, Delta::Witness(delta_witness));
    tx
}

rustler::init!("Elixir.Anoma.Arm");
