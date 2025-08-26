mod test;


rustler::init!("Elixir.Anoma.Arm.Test");
//----------------------------------------------------------------------------//
//                                Library Calls                               //
//----------------------------------------------------------------------------//

// #[rustler::nif]
// fn prove(compliance_witness: ComplianceWitness<COMMITMENT_TREE_DEPTH>) -> ComplianceUnit {
//     ComplianceUnit::create(&compliance_witness)
// }

// #[rustler::nif]
// fn prove_trivial_logic_witness(trivial_logic_witness: TrivialLogicWitness) -> LogicProof {
//     TrivialLogicWitness::prove(&trivial_logic_witness)
// }

// #[rustler::nif]
// fn prove_delta_witness(witness: DeltaWitness, message: Vec<u8>) -> DeltaProof {
//     let proof = DeltaProof::prove(&message, &witness);
//     proof
// }
// #[rustler::nif]
// fn unit_instance(unit: ComplianceUnit) -> ComplianceInstance {
//     unit.get_instance()
// }

// //----------------------------------------------------------------------------//
// //                                Debugging                                   //
// //----------------------------------------------------------------------------//



// //----------------------------------------------------------------------------//
// //                                Delta Proof                                 //
// //----------------------------------------------------------------------------//

// use arm::delta_proof::DeltaProof;
// #[rustler::nif]
// fn test_delta_proof() -> DeltaProof {
//     use k256::elliptic_curve::rand_core::OsRng;

//     let mut rng = OsRng;
//     let signing_key = SigningKey::random(&mut rng);
//     let message = b"Hello, world!";
//     let witness = DeltaWitness { signing_key };
//     DeltaProof::prove(message, &witness)
// }

// #[rustler::nif]
// fn test_delta_proof(delta_proof: DeltaProof) -> DeltaProof {
//     delta_proof
// }






// //----------------------------------------------------------------------------//
// //                                Forwarder Calldata                          //
// //----------------------------------------------------------------------------//

// // #[rustler::nif]
// // fn test_forwarder_calldata() -> ForwarderCalldata {
// //     ForwarderCalldata {
// //         untrusted_forwarder: [0u8; 20],
// //         input: vec![],
// //         output: vec![],
// //     }
// // }
// //
// // #[rustler::nif]
// // fn test_forwarder_calldata(forwarder_calldata: ForwarderCalldata) -> ForwarderCalldata {
// //     forwarder_calldata
// // }





// //----------------------------------------------------------------------------//
// //                                Mullifier Key Commitment                    //
// //----------------------------------------------------------------------------//

// #[rustler::nif]
// fn test_nullifier_key_commitment() -> NullifierKeyCommitment {
//     let (_, test_nullifier_key_commitment) = NullifierKey::random_pair();
//     test_nullifier_key_commitment
// }

// #[rustler::nif]
// fn test_nullifier_key_commitment(
//     nullifier_key_commitment: NullifierKeyCommitment,
// ) -> NullifierKeyCommitment {
//     nullifier_key_commitment
// }


