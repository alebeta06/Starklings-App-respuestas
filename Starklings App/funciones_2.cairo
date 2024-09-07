fn main() {
    call_me(3);
}

// La función call_me ahora tiene el tipo felt252 para el parámetro num
fn call_me(num: felt252) {
    println!("num is {}", num);
}