fn main() {
    let arr0 = ArrayTrait::new();  // Se crea un array vacío utilizando el trait `ArrayTrait`.
    let arr1 = arr0.clone();  // Se clona `arr0` en `arr1`, creando una copia exacta del array.
    let mut _arr1 = fill_arr(arr1);  // Se llena el array `arr1` con algunos valores llamando a la función `fill_arr`.

    // Esta línea imprime el contenido de `arr0` sin modificarla.
    print(arr0.span());
}

fn fill_arr(arr: Array<felt252>) -> Array<felt252> {
    let mut arr = arr;  // Se hace mutable el array `arr` para poder modificarlo.

    // Se agregan valores al array.
    arr.append(22);
    arr.append(44);
    arr.append(66);

    arr  // Se retorna el array modificado.
}

fn print(span: Span<felt252>) { 
    let mut i = 0;  // Inicializamos un contador para iterar sobre los elementos del array.
    print!("ARRAY: {{ len: {}, values: [ ", span.len());  // Imprimimos la longitud del array.
    
    loop {
        if span.len() == i {
            break;  // Si hemos recorrido todos los elementos, salimos del bucle.
        }
        let value = *(span.at(i));  // Accedemos al valor en el índice `i` del array.
        
        // Si no es el último elemento, imprimimos el valor seguido de una coma.
        if span.len() - 1 != i {
            print!("{}, ", value);
        } else {
            print!("{}", value);  // Si es el último elemento, imprimimos el valor sin coma.
        }
        i += 1;  // Incrementamos el contador.
    };
    
    println!(" ] }}");  // Cerramos la impresión de los valores del array.
}