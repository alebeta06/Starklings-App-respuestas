// Define la función principal del programa.
fn main() -> () {
    // Declara una variable inmutable `number` de tipo u8 y le asigna el valor 1.
    let number = 1_u8;
    
    // Imprime el valor de `number` que es 1 en la consola.
    println!("number is {}", number);

    // Inicia un nuevo bloque de código.
    {
        // Declara una nueva variable `number` y le asigna el valor 3.
        // Esta variable es independiente de la anterior debido al nuevo alcance (scope).
        let number = 3;
        
        // Imprime el valor de la nueva variable `number` en la consola.
        println!("number is {}", number);
    } // Aquí, el bloque termina y la variable `number` con valor 3 deja de existir.
}