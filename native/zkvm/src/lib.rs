//----------------------------------------------------------------------------//
//                                Delta Witness                               //
//----------------------------------------------------------------------------//

use aarm_core::delta_proof::DeltaWitness;
use k256::ecdsa::SigningKey;
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
//                                Delta Proof                               //
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

rustler::init!("Elixir.Anoma.Arm");
