fn main() {
    // Creamos un array vacío utilizando el trait `ArrayTrait::new()`.
    let arr0 = ArrayTrait::new();

    // Llamamos a la función `fill_arr`, que devuelve un array lleno, y lo almacenamos en `arr1`.
    let mut arr1 = fill_arr(arr0);

    // Imprimimos el contenido del array `arr1` utilizando la función `print`.
    print(arr1.span());

    // Aquí está el error mencionado. La solución sería convertir `arr1` en mutable, 
    // ya que necesitamos modificarlo al agregar un nuevo elemento. 
    // Esto ya se maneja utilizando `mut` al declarar `arr1`.
    arr1.append(88); // Añade el valor 88 al array `arr1`.

    // Volvemos a imprimir el array `arr1` con el nuevo valor añadido.
    print(arr1.span());
}

// Función que llena un array con tres valores y lo devuelve.
fn fill_arr(arr: Array<felt252>) -> Array<felt252> {
    // Convertimos el array en mutable para poder modificarlo.
    let mut arr = arr;

    // Agregamos valores al array.
    arr.append(22);
    arr.append(44);
    arr.append(66);

    // Devolvemos el array modificado.
    arr
}

// Función para imprimir un array. Recibe un `Span` (vista de una sección del array) como argumento.
fn print(span: Span<felt252>) { 
    let mut i = 0; // Inicializamos el índice.
    
    // Imprimimos la longitud del array y abrimos el corchete de la lista de valores.
    print!("ARRAY: {{ len: {}, values: [ ", span.len());
    
    // Bucle para recorrer todos los elementos del array.
    loop {
        if span.len() == i {
            break; // Si hemos recorrido todos los elementos, salimos del bucle.
        }
        let value = *(span.at(i)); // Accedemos al valor del array en el índice `i`.
        
        // Si no estamos en el último elemento, imprimimos el valor seguido de una coma.
        if span.len() - 1 != i {
            print!("{}, ", value);
        } else {
            // Si es el último elemento, solo imprimimos el valor.
            print!("{}", value);
        }
        i += 1; // Incrementamos el índice.
    };
    // Cerramos el corchete de la lista de valores y la impresión del array.
    println!(" ] }}");
}