//----------------------------------------------------------------------------//
//                                Functions                                   //
//----------------------------------------------------------------------------//

use aarm_core::delta_proof::{DeltaWitness};
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

rustler::init!("Elixir.Anoma.Arm");
