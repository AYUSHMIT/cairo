/// A simple provable program demo that demonstrates Cairo's ability to create
/// verifiable computations using the `#[executable]` attribute.
///
/// This example calculates a sequence of Fibonacci numbers and returns their sum,
/// demonstrating how provable programs can handle inputs and produce verified outputs.

/// Calculates the n-th Fibonacci number.
fn fib_at(n: u32) -> felt252 {
    if n == 0 {
        return 0;
    }
    if n == 1 {
        return 1;
    }
    let mut a: felt252 = 0;
    let mut b: felt252 = 1;
    let mut i: u32 = 2;
    while i <= n {
        let temp = b;
        b = a + b;
        a = temp;
        i += 1;
    }
    b
}

/// Computes the sum of the first `count` Fibonacci numbers.
fn sum_fibonacci(count: u32) -> felt252 {
    let mut sum: felt252 = 0;
    let mut i: u32 = 0;
    while i < count {
        sum += fib_at(i);
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
