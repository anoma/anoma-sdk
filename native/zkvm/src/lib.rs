//----------------------------------------------------------------------------//
//                                Delta Witness                               //
//----------------------------------------------------------------------------//

use aarm_core::delta_proof::DeltaWitness;
use k256::ecdsa::SigningKey;
use aarm::action::ForwarderCalldata;

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

use aarm::transaction::Delta;

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
    ComplianceUnit{
        proof: vec![42, 127, 203, 15, 89, 254, 33, 178, 91, 6],
        instance: vec![42, 127, 203, 15, 89, 254, 33, 178, 91, 12]
    }
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
    LogicProof{
        instance: vec![42, 127, 203, 15, 89, 254, 33, 178, 91, 6],
        proof: vec![42, 127, 203, 15, 89, 254, 33, 178, 91, 7],
        verifying_key: vec![42, 127, 203, 15, 89, 254, 33, 178, 91, 8],
    }
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
        output: vec![]
    }
}

#[rustler::nif]
fn test_forwarder_calldata(forwarder_calldata: ForwarderCalldata) -> ForwarderCalldata {
    forwarder_calldata
}

//----------------------------------------------------------------------------//
//                                Action                                      //
//----------------------------------------------------------------------------//
use aarm::action::{Action};
use aarm::compliance_unit::ComplianceUnit;
use aarm::logic_proof::{LogicProof, LogicProver};
use aarm_core::action_tree::MerkleTree;
use aarm_core::compliance::ComplianceWitness;
use aarm_core::nullifier_key::NullifierKey;
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
rustler::init!("Elixir.Anoma.Arm");
