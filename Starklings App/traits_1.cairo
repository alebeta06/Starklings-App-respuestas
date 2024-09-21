#[derive(Copy, Drop)]
struct Animal {
    noise: felt252  // La estructura `Animal` contiene un campo `noise`, que es de tipo `felt252` y representa el sonido que hace el animal.
}

trait AnimalTrait {
    fn new(noise: felt252) -> Animal;  // El trait define el método `new`, que crea una nueva instancia de `Animal` con un sonido específico.
    fn make_noise(self: Animal) -> felt252;  // El trait también define el método `make_noise`, que devuelve el sonido del animal.
}

impl AnimalImpl of AnimalTrait {  // Implementamos el trait `AnimalTrait` para la estructura `Animal`.
    fn new(noise: felt252) -> Animal {
        // Este método crea un nuevo `Animal` con el sonido especificado.
        Animal { noise: noise }
    }

    fn make_noise(self: Animal) -> felt252 {
        // Este método devuelve el sonido (`noise`) que hace el `Animal`.
        self.noise
    }
}

#[test]
fn test_traits1() {
    // En esta prueba, se crean dos instancias de `Animal` y se verifica que el sonido sea correcto.
    
    let mut cat = AnimalTrait::new('meow');  // Creamos un `Animal` que hace el sonido "meow".
    assert(cat.make_noise() == 'meow', 'Wrong noise');  // Verificamos que el sonido que hace el `cat` sea "meow".

    let mut cow = AnimalTrait::new('moo');  // Creamos un `Animal` que hace el sonido "moo".
    assert(cow.make_noise() == 'moo', 'Wrong noise');  // Verificamos que el sonido que hace la `cow` sea "moo".
}