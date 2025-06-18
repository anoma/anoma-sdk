fn main() {
    println!("Hello, world!");
    let mut actions = Vec::new();
    let mut delta_witnesses = Vec::new();
    for i in 0..10 {
        let (action, delta_witness) = aarm::action::create_an_action(i as u8);
        actions.push(action);
        let y = delta_witness.signing_key.as_nonzero_scalar().as_ref();
        println!("delta_witness: {:?}\n---", y);
        delta_witnesses.push(delta_witness);
    }
    let compressed = aarm_core::delta_proof::DeltaWitness::compress(&delta_witnesses);
    let y = compressed.signing_key.as_nonzero_scalar().as_ref();
    println!("compressed final: {:?}\n---", y);
}
