use k256::ecdsa::Signature;
use k256::elliptic_curve::FieldBytes;
use k256::sha2::digest::Mac;

fn main() {
    // create a random delta witness
    use k256::ecdsa::SigningKey;
    use k256::elliptic_curve::rand_core::OsRng;

    let mut rng = OsRng;
    let signing_key = SigningKey::random(&mut rng);

    let key_bytes = signing_key.to_bytes();
    let sk = SigningKey::from_slice(&key_bytes).unwrap();

    if(signing_key != sk) {
        println!("broken");
    }
    else {
        println!("same!")
    }

}