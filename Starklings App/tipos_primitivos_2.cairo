fn main() -> () {
    // Una cadena corta es una cadena cuya longitud es de un máximo de 31 caracteres,
    // por lo tanto, puede caber en un solo elemento de campo (felt252).
    // Las cadenas cortas en realidad son felts, no una cadena real.
    // Nota las comillas _simples_ que se usan con cadenas cortas.

    // Declara una variable mutable `my_first_initial` y la establece en la cadena corta 'C'.
    let mut my_first_initial = 'C';

    // Verifica si `my_first_initial` es un carácter alfabético.
    if is_alphabetic(
        ref my_first_initial
    ) {
        println!(" Alphabetical !");  // Si es alfabético, imprime "Alphabetical!"
    } else if is_numeric(
        ref my_first_initial
    ) {
        println!(" Numerical !");  // Si es numérico, imprime "Numerical!"
    } else {
        println!(" Neither alphabetic nor numeric!");  // Si no es ni alfabético ni numérico, imprime esto.
    }

    // Declara otra variable mutable `your_character` y la establece en la cadena corta '2'.
    let mut your_character = '2';

    // Verifica si `your_character` es un carácter alfabético.
    if is_alphabetic(
        ref your_character
    ) {
        println!(" Alphabetical !");  // Si es alfabético, imprime "Alphabetical!"
    } else if is_numeric(
        ref your_character
    ) {
        println!(" Numerical!");  // Si es numérico, imprime "Numerical!"
    } else {
        println!(" Neither alphabetic nor numeric!");  // Si no es ni alfabético ni numérico, imprime esto.
    }
}

// Función que verifica si un carácter es alfabético.
fn is_alphabetic(ref char: felt252) -> bool {
    if char >= 'a' {  // Comprueba si el carácter está en el rango de letras minúsculas.
        if char <= 'z' {
            return true;
        }
    }
    if char >= 'A' {  // Comprueba si el carácter está en el rango de letras mayúsculas.
        if char <= 'Z' {
            return true;
        }
    }
    false  // Si no es alfabético, retorna false.
}

// Función que verifica si un carácter es numérico.
fn is_numeric(ref char: felt252) -> bool {
    if char >= '0' {  // Comprueba si el carácter está en el rango de dígitos.
        if char <= '9' {
            return true;
        }
    }
    false  // Si no es numérico, retorna false.
}

// Implementación de comparaciones parciales para `felt252`
// que permite comparar `felt252` como si fueran números enteros.
impl Felt252PartialOrd of PartialOrd<felt252> {
    fn le(lhs: felt252, rhs: felt252) -> bool {
        Into::<felt252, u256>::into(lhs) <= Into::<felt252, u256>::into(rhs)
    }

    fn ge(lhs: felt252, rhs: felt252) -> bool {
        Into::<felt252, u256>::into(lhs) >= Into::<felt252, u256>::into(rhs)
    }

    fn lt(lhs: felt252, rhs: felt252) -> bool {
        Into::<felt252, u256>::into(lhs) < Into::<felt252, u256>::into(rhs)
    }

    fn gt(lhs: felt252, rhs: felt252) -> bool {
        Into::<felt252, u256>::into(lhs) > Into::<felt252, u256>::into(rhs)
    }
}