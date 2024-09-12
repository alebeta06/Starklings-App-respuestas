fn create_array() -> Array<felt252> {
    // Creamos un nuevo array vacío de tipo felt252 utilizando el trait `ArrayTrait`.
    let mut a = ArrayTrait::new();
    
    // Agregamos tres elementos al array: 0, 1, y 2.
    a.append(0);
    a.append(1);
    a.append(2);

    // Devolvemos el array creado.
    a
}

#[test]
fn test_array_len() {
    // Llamamos a la función `create_array` para crear un array y asignarlo a `a`.
    let mut a = create_array();
    
    // Comprobamos si la longitud del array es 3.
    assert(a.len() == 3, 'Array length is not 3');
    
    // Eliminamos y verificamos que el primer elemento sea 0.
    assert(a.pop_front().unwrap() == 0, 'First element is not 0');
}