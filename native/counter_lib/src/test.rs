use crate::counter_logic::CounterLogic;
use arm::logic_proof::LogicProver;
use arm::nullifier_key::NullifierKey;
use arm::resource::Resource;
use rand::Rng;

/// Create a new ephemeral counter.
pub fn ephemeral_counter() -> (Resource, NullifierKey) {
    let mut rng = rand::thread_rng();
    let (nf_key, nf_key_cm) = NullifierKey::random_pair();
    let label_ref: [u8; 32] = rng.gen(); // Random label reference, it should be unique for each counter
    let nonce: [u8; 32] = rng.gen(); // Random nonce for the ephemeral resource
    let ephemeral_resource = Resource::create(
        CounterLogic::verifying_key_as_bytes(),
        label_ref.to_vec(),
        1,
        convert_counter_to_value_ref(0u128), // Initialize with value/counter 0
        true,
        nonce.to_vec(),
        nf_key_cm,
    );
    (ephemeral_resource, nf_key)
}

/// This function initializes a counter resource from an ephemeral counter
/// resource and its nullifier key. It sets the resource as non-ephemeral, renews
/// its randomness, resets the nonce from the ephemeral counter, and sets the
/// value reference to 1 (the initial counter value). It also renews the
/// nullifier key(commitment) for the counter resource.
pub fn init_counter_resource(
    ephemeral_counter: &Resource,
    ephemeral_counter_nf_key: &NullifierKey,
) -> (Resource, NullifierKey) {
    let (nf_key, nf_key_cm) = NullifierKey::random_pair();
    // to create a counter, start with a clone of the ephemeral counter
    let mut init_counter = ephemeral_counter.clone();

    // the created counter is not ephemeral
    init_counter.is_ephemeral = false;

    // set the random seed to a new random value
    init_counter.reset_randomness();

    // the nonce of the created counter is the nullifier key commitment of the ephemeral counter
    init_counter.set_nonce_from_nf(ephemeral_counter, ephemeral_counter_nf_key);

    // the value of the created counter is 1
    init_counter.set_value_ref(convert_counter_to_value_ref(1u128));

    // the nullifier key commitment is computed based on the nullifier keypair
    init_counter.set_nf_commitment(nf_key_cm.clone());
    (init_counter, nf_key)
}

/// Converts a u128 value to a byte vector padded with 0s.
fn convert_counter_to_value_ref(value: u128) -> Vec<u8> {
    let mut arr = [0u8; 32];
    let bytes = value.to_le_bytes();
    arr[..16].copy_from_slice(&bytes); // left-align, right-pad with 0
    arr.to_vec()
}

fn counter_transaction() {
    let (ephemeral_counter, ephemeral_nf_key) = ephemeral_counter();
    let (counter_resource, counter_nf_key) =
        init_counter_resource(&ephemeral_counter, &ephemeral_nf_key);
}
