fn main() -> () {
    // Declaramos una tupla 'cat' que contiene un nombre y una edad.
    // La tupla contiene dos valores: un nombre ('Furry McFurson') y un número (3).
    let cat = ('Furry McFurson', 3);

    // Desestructuramos la tupla 'cat' en dos variables: 'name' y 'age'.
    // También declaramos que ambas variables son de tipo 'felt252', que es un tipo de campo en Cairo.
    let (name, age): (felt252, felt252) = cat;

    // Imprimimos el nombre del gato usando la variable 'name'.
    println!("name is {}", name);

    // Imprimimos la edad del gato usando la variable 'age'.
    println!("age is {}", age);
}