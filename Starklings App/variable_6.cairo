// Define una constante `NUMBER` de tipo u32 (entero sin signo de 32 bits) con el valor 3.
const NUMBER: u32 = 3;

// Define una constante `SMALL_NUMBER` de tipo u8 (entero sin signo de 8 bits) con el valor 3.
const SMALL_NUMBER: u8 = 3_u8;

// Define la función principal del programa.
fn main() -> () {
    // Imprime el valor de `NUMBER` en la consola.
    println!("NUMBER is {}", NUMBER);
    
    // Imprime el valor de `SMALL_NUMBER` en la consola.
    println!("SMALL_NUMBER is {}", SMALL_NUMBER);
}