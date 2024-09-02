// Define la función principal del programa.
fn main() -> () {
    // Declara una variable inmutable `x` y le asigna el valor 3.
    let x = 3;
    
    // Imprime el valor de `x` en la consola.
    println!("x is {}", x);
    
    // Declara una nueva variable mutable `x` y le asigna el valor 5.
    // Esta línea "somete" a la variable `x`, creando una nueva variable
    // con el mismo nombre, pero permitiendo que su valor cambie.
    let mut x = 5;
    
    // Imprime el nuevo valor de `x` en la consola.
    println!("x is now {}", x);
}