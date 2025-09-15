use arm::compliance::ComplianceInstance;
use arm::compliance::ComplianceWitness;
use arm::compliance_unit::ComplianceUnit;
use arm::delta_proof::DeltaProof;
use arm::delta_proof::DeltaWitness;
use arm::encryption::{random_keypair, Ciphertext, SecretKey};
use arm::logic_proof::LogicVerifier;
use arm::logic_proof::LogicVerifierInputs;
use arm::rustler_util::{at_struct, RustlerDecoder, RustlerEncoder};
use arm::transaction::Transaction;
use k256::AffinePoint;
use rustler::types::map::map_new;
use rustler::{atoms, nif, Decoder, Encoder, Env, NifResult, Term};

/// A Keypair is a struct that holds a SecretKey and Affinepoint.
/// It is used here to implement the Encoder and RusterEncoder trait.
/// The encoded value is a tuple.
pub struct Keypair {
    pub secret: SecretKey,
    pub public: AffinePoint,
}

atoms! {
    at_secret_key = "secret_key",
    at_public_key = "public_key",
    at_keypair_key = "Elixir.Anoma.Arm.Keypair"
}

impl Encoder for Keypair {
    fn encode<'a>(&self, env: Env<'a>) -> Term<'a> {
        let secret_key = self.secret.rustler_encode(env).unwrap();
        let public_key = self.public.rustler_encode(env).unwrap();

        let map = map_new(env)
            .map_put(at_struct().encode(env), at_keypair_key())
            .unwrap()
            .map_put(at_secret_key(), secret_key)
            .unwrap()
            .map_put(at_public_key(), public_key);

        map.expect("failed to encode Keypair")
    }
}

impl<'a> Decoder<'a> for Keypair {
    fn decode(term: Term<'a>) -> NifResult<Self> {
        let secret_term = term.map_get(at_secret_key().encode(term.get_env()))?;
        let secret: SecretKey = RustlerDecoder::rustler_decode(secret_term)?;

        let public_term = term.map_get(at_public_key().encode(term.get_env()))?;
        let public: AffinePoint = RustlerDecoder::rustler_decode(public_term)?;
        Ok(Keypair { secret, public })
    }
}

#[nif]
/// Generates a random pair of SecretKey and AffinePoint.
pub fn random_key_pair() -> Keypair {
    let (secret, public) = random_keypair();
    Keypair { secret, public }
}

#[nif]
//// Returns the ComplianceInstance from within a ComplianceUnit
fn compliance_unit_instance(unit: ComplianceUnit) -> ComplianceInstance {
    unit.get_instance()
}

#[nif]
fn encrypt_cipher(cipher: Vec<u8>, keypair: Keypair, nonce: Vec<u8>) -> Ciphertext {
    Ciphertext::encrypt(
        cipher.as_ref(),
        &keypair.public,
        &keypair.secret,
        nonce.try_into().expect("REASON"),
    )
}

#[nif]
pub fn decrypt_cipher(cipher_bytes: Vec<u8>, keypair: Keypair) -> Option<Vec<u8>> {
    let cipher_text = Ciphertext::from_bytes(cipher_bytes);
    let decipher_result = cipher_text.decrypt(&keypair.secret);
    match decipher_result {
        Ok(result) => Some(result),
        Err(_) => None,
    }
}



#[nif]
/// Generate a compliance unit from a compliance witness.
fn prove_compliance_witness(compliance_witness: ComplianceWitness) -> ComplianceUnit {
    ComplianceUnit::create(&compliance_witness)
}

#[nif]
/// Converts a logic verifier to a logic verifier inputs.
/// this nif is here because this conversion relies on the Journal
/// implementation of Risc0 ZKVM.
fn convert(logic_verifier : LogicVerifier) -> LogicVerifierInputs {
    logic_verifier.into()
}

#[nif]
/// Generate a proof for a delta witness.
fn prove_delta_witness(witness: DeltaWitness, message: Vec<u8>) -> DeltaProof {
    let proof = DeltaProof::prove(&message, &witness);
    proof
}


#[nif]
/// Given a transaction, puts in the delta proof.
pub fn generate_delta_proof(transaction: Transaction) -> Transaction {
    let mut tx = transaction.clone();
    tx.generate_delta_proof();
    tx
}


rustler::init!("Elixir.Anoma.Arm");
