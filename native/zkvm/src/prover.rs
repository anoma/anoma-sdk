use risc0_zkvm::{default_prover, ExecutorEnv, Receipt};

pub const LD_GUEST_ELF: &[u8] = include_bytes!("../ld_guest.bin");
pub const LD_GUEST_ID: [u32; 8] = [
    4175664686, 4091976521, 1849551798, 26727266, 738936969, 193318169, 2773179780, 3114104,
];

pub fn generate_proof(a: u64, b: u64) -> (Receipt, u64) {
    let env = ExecutorEnv::builder()
        // Send a & b to the guest
        .write(&a)
        .unwrap()
        .write(&b)
        .unwrap()
        .build()
        .unwrap();

    // Obtain the default prover.
    let prover = default_prover();

    // Produce a receipt by proving the specified ELF binary.
    let receipt = prover.prove(env, LD_GUEST_ELF).unwrap().receipt;

    // Extract journal of receipt (i.e. output c, where c = a * b)
    let c: u64 = receipt.journal.decode().expect(
        "Journal output should deserialize into the same types (& order) that it was written",
    );

    // Report the product
    println!("I know the factors of {}, and I can prove it!", c);

    (receipt, c)
}

pub fn verify_proof(receipt: Receipt) -> bool {
    match receipt.verify(LD_GUEST_ID) {
        Ok(()) => {
            return false;
        }
        Err(_error) => {
            return true;
        }
    }
}
