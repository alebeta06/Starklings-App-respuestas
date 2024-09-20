#[derive(Drop)]
struct Number {
    value: u32,  // Definimos una estructura `Number` que contiene un solo campo `value` de tipo u32.
}

fn main() {
    // Se crea una instancia mutable de `Number` con un valor inicial de 1111111.
    let mut number = Number { value: 1111111 };

    get_value(ref number);  // Se llama a `get_value`, pasando la referencia de `number`.
    
    set_value(number);  // Se llama a `set_value`, pasando la propiedad de `number` (ownership).
}

// Esta función toma una referencia a `number` y devuelve su valor.
// No toma posesión de `number`, y por lo tanto no modifica el valor.
fn get_value(ref number: Number) -> u32 {
    number.value  // Devuelve el campo `value` del struct `Number`.
}

// Esta función toma posesión completa de `number`.
// Modifica el valor de `number` y lo reasigna dentro de la función.
fn set_value(mut number: Number) {
    let value = 2222222;  // Se define un nuevo valor.
    number = Number { value };  // Se reasigna el valor dentro del struct.
    println!("{}", number.value);  // Se imprime el nuevo valor.
}