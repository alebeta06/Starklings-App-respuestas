fn main() {
    let arr0 = ArrayTrait::new();  // Se crea un array vacío utilizando el trait `ArrayTrait`.

    let mut arr1 = fill_arr(arr0);  // Se llena el array `arr0` con algunos valores utilizando la función `fill_arr`.

    print(arr1.span());  // Imprime el contenido del array después de haber sido llenado.

    arr1.append(88);  // Se agrega el número 88 al array `arr1`.

    print(arr1.span());  // Imprime el contenido del array nuevamente después de agregar el número 88.
}

fn fill_arr(mut arr: Array<felt252>) -> Array<felt252> {
    // Esta función agrega tres valores (22, 44, 66) al array.
    arr.append(22);
    arr.append(44);
    arr.append(66);

    arr  // Retorna el array modificado.
}

fn print(span: Span<felt252>) { 
    let mut i = 0;  // Inicializa un contador para recorrer el array.
    print!("ARRAY: {{ len: {}, values: [ ", span.len());  // Imprime la longitud del array.

    loop {
        if span.len() == i {  // Condición para detener el bucle cuando se recorre todo el array.
            break;
        }
        let value = *(span.at(i));  // Obtiene el valor en el índice actual.

        // Si no es el último elemento, imprime el valor seguido de una coma.
        if span.len() - 1 != i {
            print!("{}, ", value);
        } else {
            print!("{}", value);  // Imprime el último valor sin coma.
        }
        i += 1;  // Incrementa el contador.
    };
    println!(" ] }}");  // Cierra la impresión del array.
}