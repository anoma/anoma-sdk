# Anoma


## ZKVM Directory Structure

 - `zkvm`: The library that implements the NIFs for Elixir.
 - `aarm_core` : The library from Anoma that contains some data structures. Ideally these should be merged with zkvm.
 - `zkvm_guest`: The zkvm guest library. t=This compiles the binaries used to generate proofs and it not used in the library itself and is only here to keep it in the same repository.


## Build `zkvm_guest`

 - Compile the zkvm_guest project

```shell
cd native/zkvm_guest
cargo build
cd -
cp native/zkvm_guest/target/riscv-guest/methods/ld_guest/riscv32im-risc0-zkvm-elf/release/ld_guest.bin native/zkvm/ld_guest.bin
```


Make sure to set `export RISC0_DEV_MODE=true` to allow proving on m1.