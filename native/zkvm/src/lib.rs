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

// #[derive(Debug)]
// struct ResourceP {
//     pub name: u64,
//     pub hash: Digest,
// }

// impl<'a> Decoder<'a> for ResourceP {
//     fn decode(term: Term<'a>) -> NifResult<Self> {
//         // fetch the name field
//         let name  = term.map_get(Atom::from_str(term.get_env(), "name")?)?.decode::<u64>()?;
//         println!("name");

//         // fetch the digest bytes
//         let binary = term.map_get(Atom::from_str(term.get_env(), "untrusted_forwarder")?);
//         match binary {
//             Ok(bin) => {
//                 println!("term {:?}", bin);
//                 println!("bytes {}", DIGEST_BYTES);
//                 let binn = Binary::from_term(bin);
//                 match binn {
//                     Ok(binn) => {
//                         println!("binn");
//                         let vec = binn.to_vec();
//                         println!("vec {}", vec.iter().count());
//                         println!("binn");
//                         let arr : [u8; DIGEST_BYTES] = vec.try_into().unwrap();
//                         println!("binn");
//                         println!("arr {:?}", arr);
//                         let digest = Digest::from_bytes(arr);
//                         println!("digest");
//                     }
//                     Err(err) => {
//                         println!("err {:?}", err);
//                     }

//                 }
//                 println!("words {}", DIGEST_WORDS);
//                 // let vec = binn.to_vec();
//                 // println!("vec {}", vec.iter().count());
//                 // let arr : [u8; DIGEST_BYTES] = vec.try_into().unwrap();
//                 //
//                 // println!("{:?} binaryd!", arr);

//             }
//             Err(_) => {println!("error!");}
//         };

//         let digest_binary : Binary  = Binary::from_term(binary?)?;
//         let digest_bytes: Vec<u8> = digest_binary.to_vec();
//         let digest_arr : [u8; DIGEST_BYTES] = digest_bytes.try_into().unwrap();
//         println!("digest_arr {:?}", digest_arr);
//         let digest = Digest::from_bytes(digest_arr);

//         Ok(ResourceP {
//             name: name,
//             hash: digest,
//         })
//     }
// }

// impl Encoder for ResourceP {
//     fn encode<'a>(&self, env: Env<'a>) -> Term<'a> {
//         use rustler::types::map::map_new;

//         // encode the name
//         let map = map_new(env);
//         let map = map
//             .map_put(Atom::from_str(env, "name").unwrap(), self.name.encode(env))
//             .unwrap();

//         // encode the Digest
//         let digest: Digest = self.hash;
//         let digest_bytes = digest.as_bytes();
//         let mut digest_bin = OwnedBinary::new(DIGEST_BYTES).expect("allocation failed");
//         digest_bin.as_mut_slice().write_all(&digest_bytes).unwrap();
//         let bin = Binary::from_owned(digest_bin, env);
//         let map = map
//             .map_put(
//                 Atom::from_str(env, "untrusted_forwarder").unwrap(),
//                 bin,
//             )
//             .unwrap();

//         // store the struct name
//         let map = map
//             .map_put(
//                 Atom::from_str(env, "__struct__").unwrap(),
//                 Atom::from_str(env, "Elixir.Anoma.Zkvm.ForwarderCalldata").unwrap(),
//             )
//             .unwrap();

//         map
//     }
// }

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

rustler::init!("Elixir.Anoma.Zkvm");
