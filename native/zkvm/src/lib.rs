use crate::prover::generate_proof;
use crate::prover::verify_proof;
use std::io::Write;

use risc0_zkvm::{Digest, Receipt};

use rustler;

use aarm::action::ForwarderCalldata;
use aarm_core::resource::Resource;
use rustler::{
    nif, Atom, Binary, Decoder, Encoder, Env, Error, NifResult, NifStruct, OwnedBinary, Term,
};

use risc0_zkvm::sha::{Digestible, DIGEST_BYTES, DIGEST_WORDS};
use std::ops::Deref;

mod prover;

//----------------------------------------------------------------------------//
//                                Functions                                   //
//----------------------------------------------------------------------------//

#[nif]
fn testfunc() -> Resource {
    Resource::default()
}

#[nif]
fn echofunc(resource_p: Resource) -> Resource {
    resource_p
}

#[nif]
fn prove(a: u64, b: u64) -> String {
    println!("params: {}, {}", a, b);
    let (receipt, _number): (Receipt, u64) = generate_proof(a, b);

    let serialized: String = serde_json::to_string(&receipt).unwrap();
    serialized
}

#[nif]
fn verify(receipt: String) -> bool {
    match serde_json::from_str(&receipt) {
        Ok(r) => {
            return verify_proof(r);
        }
        _ => {
            return false;
        }
    }
}

rustler::init!("Elixir.Anoma.Arm");
