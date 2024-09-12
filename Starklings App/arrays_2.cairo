fn create_array() -> Array<felt252> {
    // Creamos un array con un solo elemento 42.
    let mut a = ArrayTrait::new();
    a.append(42);  // Agregamos 42 al array
    a
}

fn remove_element_from_array(
    ref a: Array<felt252>
) { 
    // TODO: Aquí usamos el método `pop_front()` para remover el primer elemento del array.
    // Este método devuelve el primer elemento y lo elimina del array.
    a.pop_front().unwrap();  // Usamos unwrap para asegurarnos de obtener el valor directamente
}

#[test]
fn test_arrays2() {
    let mut a = create_array();
    // Verificamos que el primer elemento del array sea 42
    assert(*a.at(0) == 42, 'First element is not 42');
}

#[test]
fn test_arrays2_empty() {
    let mut a = create_array();
    // Llamamos a la función que remueve el elemento
    remove_element_from_array(ref a);
    // Verificamos que la longitud del array ahora sea 0
    assert(a.len() == 0, 'Array length is not 0');
}