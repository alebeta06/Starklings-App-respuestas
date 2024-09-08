fn main() {
    // Pasa un valor del tipo u64 a la función call_me
    call_me(42_u64);
}

// La función call_me recibe un argumento num de tipo u64
fn call_me(num: u64) {
    println!("num is {}", num);
}