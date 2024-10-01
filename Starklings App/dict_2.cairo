use core::dict::{Felt252DictTrait, Felt252Dict}; 

fn multiply_element_by_10(ref dict: Felt252Dict<u32>, n: usize) {
    // Esta función multiplica por 10 los elementos almacenados en los índices desde 0 hasta n.
    // `n` es el tamaño hasta donde se quiere realizar la operación de multiplicación.
    let mut number_felt: felt252 = n.try_into().unwrap(); 
    // Convierte el tamaño `n` a tipo felt252, que es un tipo numérico utilizado en Cairo. 
    loop {
        if number_felt == 0 {
            // Cuando `number_felt` llegue a 0, el ciclo termina.
            break;
        }
        let index: felt252 = number_felt - 1;
        // Restamos 1 a `number_felt` para obtener el índice.
        let element = dict.get(index); 
        // Se obtiene el elemento almacenado en ese índice del diccionario.
        dict.insert(index, element * 10); 
        // Se multiplica por 10 y se inserta de nuevo en el mismo índice.
        number_felt = index; 
        // Actualizamos `number_felt` para seguir con el ciclo.
    }
}

// Pruebas para verificar el funcionamiento de la función.
#[test]
#[available_gas(2000000000)]
fn test_3() {
    let mut dict: Felt252Dict<u32> = Default::default(); 
    // Inicializamos un diccionario con valores predeterminados.
    dict.insert(0, 1);
    dict.insert(1, 2);
    dict.insert(2, 3);
    
    multiply_element_by_10(ref dict, 3); 
    // Llamamos a la función para multiplicar los elementos del índice 0 al 2.

    assert(dict.get(0) == 10, 'First element is not 10');
    // Verificamos que el primer elemento es 10.
    assert(dict.get(1) == 20, 'Second element is not 20');
    // Verificamos que el segundo elemento es 20.
    assert(dict.get(2) == 30, 'Third element is not 30');
    // Verificamos que el tercer elemento es 30.
}

#[test]
#[available_gas(200000000)]
fn test_4() {
    let mut dict: Felt252Dict<u32> = Default::default(); 
    // Se vuelve a inicializar el diccionario.
    dict.insert(0, 1);
    dict.insert(1, 2);
    dict.insert(2, 5);
    dict.insert(3, 10);

    multiply_element_by_10(ref dict, 4);
    // Multiplica por 10 los elementos desde el índice 0 al 3.

    assert(dict.get(2) == 50, 'First element is not 50');
    // Verifica que el valor en el índice 2 es 50.
    assert(dict.get(3) == 100, 'First element is not 100');
    // Verifica que el valor en el índice 3 es 100.
}
