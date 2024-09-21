#[derive(Copy, Drop)]
struct Fish {
    noise: felt252, // 'noise' representa el sonido característico del pez.
    distance: u32,  // 'distance' indica la distancia que el pez ha recorrido.
}

#[derive(Copy, Drop)]
struct Dog {
    noise: felt252, // 'noise' representa el sonido del perro (ladrido).
    distance: u32,  // 'distance' indica la distancia que el perro ha caminado.
}

// El trait `AnimalTrait` define un conjunto de métodos comunes que puede implementar cualquier animal.
trait AnimalTrait<T> {
    // Método para crear una nueva instancia del animal.
    fn new() -> T;
    // Método para obtener el ruido que hace el animal.
    fn make_noise(self: T) -> felt252;
    // Método para obtener la distancia que ha recorrido el animal.
    fn get_distance(self: T) -> u32;
}

// Definimos el trait específico para los peces.
trait FishTrait {
    // Método para hacer que el pez nade, incrementando la distancia.
    fn swim(ref self: Fish) -> ();
}

// Definimos el trait específico para los perros.
trait DogTrait {
    // Método para hacer que el perro camine, incrementando la distancia.
    fn walk(ref self: Dog) -> ();
}

// Implementamos `AnimalTrait` para el tipo `Fish`.
impl AnimalFishImpl of AnimalTrait<Fish> {
    fn new() -> Fish {
        // Un nuevo pez se crea con el sonido 'blub' y con distancia inicial 0.
        Fish { noise: 'blub', distance: 0 }
    }
    
    fn make_noise(self: Fish) -> felt252 {
        self.noise // Retorna el sonido del pez.
    }
    
    fn get_distance(self: Fish) -> u32 {
        self.distance // Retorna la distancia que ha recorrido el pez.
    }
}

// Implementamos `AnimalTrait` para el tipo `Dog`.
impl AnimalDogImpl of AnimalTrait<Dog> {
    fn new() -> Dog {
        // Un nuevo perro se crea con el sonido 'woof' y con distancia inicial 0.
        Dog { noise: 'woof', distance: 0 }
    }
    
    fn make_noise(self: Dog) -> felt252 {
        self.noise // Retorna el sonido del perro.
    }
    
    fn get_distance(self: Dog) -> u32 {
        self.distance // Retorna la distancia que ha caminado el perro.
    }
}

// Implementamos `FishTrait` para el tipo `Fish`.
impl FishImpl of FishTrait {
    fn swim(ref self: Fish) -> () {
        // Incrementa la distancia del pez cuando nada.
        self.distance += 1;
    }
}

// Implementamos `DogTrait` para el tipo `Dog`.
impl DogImpl of DogTrait {
    fn walk(ref self: Dog) -> () {
        // Incrementa la distancia del perro cuando camina.
        self.distance += 1;
    }
}

// Pruebas para verificar las implementaciones de `AnimalTrait`, `FishTrait`, y `DogTrait`.
#[test]
fn test_traits3() {
    // Prueba con el pez
    let mut salmon: Fish = AnimalTrait::new(); // Creamos un nuevo pez.
    salmon.swim(); // El pez nada y aumenta la distancia.
    assert(salmon.make_noise() == 'blub', 'Wrong noise'); // Verificamos que el sonido es correcto.
    assert(salmon.get_distance() == 1, 'Wrong distance'); // Verificamos que la distancia aumentó correctamente.

    // Prueba con el perro
    let mut dog: Dog = AnimalTrait::new(); // Creamos un nuevo perro.
    dog.walk(); // El perro camina y aumenta la distancia.
    assert(dog.make_noise() == 'woof', 'Wrong noise'); // Verificamos que el sonido es correcto.
    assert(dog.get_distance() == 1, 'Wrong distance'); // Verificamos que la distancia aumentó correctamente.
}