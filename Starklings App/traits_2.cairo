#[derive(Copy, Drop)]
struct Cat {
    noise: felt252,  // La estructura `Cat` contiene un campo `noise`, que es un felt252 representando el sonido que hace el gato.
}

#[derive(Copy, Drop)]
struct Cow {
    noise: felt252,  // La estructura `Cow` contiene un campo `noise`, que es un felt252 representando el sonido que hace la vaca.
}

// Definimos un trait genérico `AnimalTrait` que será implementado por diferentes tipos de animales (en este caso, Cat y Cow).
trait AnimalTrait<T> {
    // El método `new` crea una nueva instancia del tipo `T`.
    fn new() -> T;

    // El método `make_noise` devuelve el sonido que hace el animal.
    fn make_noise(self: T) -> felt252;
}

// Implementamos el trait `AnimalTrait` para la estructura `Cat`.
impl CatImpl of AnimalTrait<Cat> {
    fn new() -> Cat {
        // Al crear un gato, el sonido se establece como "meow".
        Cat { noise: 'meow' }
    }

    fn make_noise(self: Cat) -> felt252 {
        // Devuelve el sonido del gato (meow).
        self.noise
    }
}

// Implementamos el trait `AnimalTrait` para la estructura `Cow`.
impl CowImpl of AnimalTrait<Cow> {
    fn new() -> Cow {
        // Al crear una vaca, el sonido se establece como "moo".
        Cow { noise: 'moo' }
    }

    fn make_noise(self: Cow) -> felt252 {
        // Devuelve el sonido de la vaca (moo).
        self.noise
    }
}

// Prueba para verificar que el sonido generado por `Cat` y `Cow` sea el correcto.
#[test]
fn test_traits2() {
    let kitty: Cat = AnimalTrait::new();  // Se crea una instancia de `Cat`.
    assert(kitty.make_noise() == 'meow', 'Wrong noise');  // Verifica que el sonido del gato sea "meow".

    let cow: Cow = AnimalTrait::new();  // Se crea una instancia de `Cow`.
    assert(cow.make_noise() == 'moo', 'Wrong noise');  // Verifica que el sonido de la vaca sea "moo".
} 