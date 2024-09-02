// Define la función principal del programa.
// En Cairo, la función `main` es el punto de entrada del programa.

fn main() -> () {
    // Declara una variable local `x` y le asigna el valor 5.
    let x = 5;
    
    // Usa la función `println` para imprimir un mensaje en la consola.
    // "{}" es un marcador de posición que se sustituye por el valor de `x`.
    println!("x is {}", x);
}

// El programa termina después de que `main` se ejecuta completamente.