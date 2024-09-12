fn create_array() -> Array<felt252> {
    // Se crea un nuevo array vacío utilizando el trait ArrayTrait.
    let mut a = ArrayTrait::new();
    
    // Se agregan valores al array: 0, 1, 2 y 3.
    a.append(0);
    a.append(1);
    a.append(2);
    a.append(3);
    
    // Se elimina el primer elemento del array con `pop_front`.
    // Después de este llamado, el array quedaría como [1, 2, 3].
    a.pop_front().unwrap();
    
    // Retornamos el array modificado.
    a
}

#[test]
fn test_arrays3() {
    let mut a = create_array();
   
    // Aquí estamos accediendo al índice 2 del array, 
    // que tras la eliminación del primer elemento debería ser el valor `3`.
    a.at(2);
}