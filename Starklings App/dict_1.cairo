use core::dict::{Felt252DictTrait, Felt252Dict};

// Esta función crea un diccionario (similar a un mapa o hash map en otros lenguajes)
// que asocia claves de tipo felt252 con valores de tipo u32.
fn create_dictionary() -> Felt252Dict<u32> {
    let mut dict: Felt252Dict<u32> = Default::default(); // Se inicializa un diccionario vacío.

    // Añadimos elementos al diccionario, donde 'A', 'B', y 'bob' son claves de tipo felt252
    // y los valores asociados son números de tipo u32.
    dict.insert('A', 1); // Clave: 'A', Valor: 1
    dict.insert('B', 2); // Clave: 'B', Valor: 2
    dict.insert('bob', 3); // Clave: 'bob', Valor: 3

    dict // Retorna el diccionario con los valores añadidos.
}

// Esta prueba verifica el correcto funcionamiento de la función `create_dictionary`.
// No se debe cambiar nada en esta función de prueba.
#[test]
#[available_gas(200000)] // Límite de gas para la ejecución de la prueba.
fn test_dict() {
    let mut dict = create_dictionary(); // Se crea un diccionario utilizando la función anterior.

    // Se comprueba que el valor asociado a la clave 'A' sea 1.
    assert(dict.get('A') == 1, 'First element is not 1');
    
    // Se comprueba que el valor asociado a la clave 'B' sea 2.
    assert(dict.get('B') == 2, 'Second element is not 2');
    
    // Se comprueba que el valor asociado a la clave 'bob' sea 3.
    assert(dict.get('bob') == 3, 'Third element is not 3');
}