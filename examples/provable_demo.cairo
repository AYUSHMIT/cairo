/// A simple provable program demo that demonstrates Cairo's ability to create
/// verifiable computations using the `#[executable]` attribute.
///
/// This example calculates a sequence of Fibonacci numbers and returns their sum,
/// demonstrating how provable programs can handle inputs and produce verified outputs.
///
/// # STARK Proof Generation
///
/// This program can generate proof artifacts for use with STARK provers like:
/// - **Stone Prover** (https://github.com/starkware-libs/stone-prover) - StarkWare's prover
/// - **Stwo Prover** (https://github.com/starkware-libs/stwo) - Next-gen STARK prover
/// - **Platinum Prover** (https://github.com/lambdaclass/lambdaworks) - Lambdaclass prover
///
/// To generate proof artifacts, run:
/// ```bash
/// cargo run --bin cairo-execute -- --single-file examples/provable_demo.cairo \
///     --standalone --args 10 --layout small \
///     --trace-file trace.bin --memory-file memory.bin \
///     --air-public-input public_input.json --air-private-input private_input.json
/// ```
///
/// The generated files are:
/// - `trace.bin` - Execution trace for the prover
/// - `memory.bin` - Memory layout for the prover
/// - `public_input.json` - AIR public inputs (program hash, outputs, etc.)
/// - `private_input.json` - AIR private inputs (witness data)
///
/// These files can then be fed to a STARK prover to generate a cryptographic proof
/// that the computation was executed correctly.

/// Computes the sum of the first `count` Fibonacci numbers in a single pass.
/// Uses O(n) time complexity by computing Fibonacci numbers and their running sum together.
fn sum_fibonacci(count: u32) -> felt252 {
    if count == 0 {
        return 0;
    }
    let mut sum: felt252 = 0;
    let mut a: felt252 = 0;
    let mut b: felt252 = 1;
    let mut i: u32 = 0;
    while i < count {
        sum += a;
        let temp = b;
        b = a + b;
        a = temp;
        i += 1;
    }
    sum
}

/// Entry point for the provable program.
/// Takes a count as input and returns the sum of the first `count` Fibonacci numbers.
///
/// This function is marked with `#[executable]` which means:
/// 1. It can be compiled to a provable program
/// 2. The execution can be verified using a STARK proof
/// 3. Inputs are deserialized and outputs are serialized automatically
#[executable]
pub fn provable_fib_sum(count: u32) -> felt252 {
    sum_fibonacci(count)
}
