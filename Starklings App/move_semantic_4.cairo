fn main() {

    let mut arr1 = fill_arr();  // Se llena un nuevo array con algunos valores predefinidos.

    print(arr1.span());  // Imprime el contenido del array tras ser inicializado con valores.

    arr1.append(88);  // Se agrega el valor 88 al array después de la inicialización.

    print(arr1.span());  // Imprime el array nuevamente para mostrar el nuevo estado con el 88 agregado.
}

// `fill_arr()` ya no recibe un array como argumento, sino que lo crea internamente.
fn fill_arr() -> Array<felt252> {
    let mut arr = ArrayTrait::<felt252>::new();  // Se crea un nuevo array vacío de tipo `felt252`.

    arr.append(22);  // Agrega el número 22 al array.
    arr.append(44);  // Agrega el número 44 al array.
    arr.append(66);  // Agrega el número 66 al array.

    arr  // Retorna el array con los valores agregados.
}

fn print(span: Span<felt252>) { 
    let mut i = 0;
    print!("ARRAY: {{ len: {}, values: [ ", span.len());  // Imprime la longitud del array y abre la estructura de impresión.

    loop {
        if span.len() == i {  // Condición para terminar el bucle cuando se recorre todo el array.
            break;
        }
        let value = *(span.at(i));  // Obtiene el valor en la posición `i`.

        // Si no es el último elemento, imprime el valor seguido de una coma.
        if span.len() - 1 != i {
            print!("{}, ", value);
        } else {
            print!("{}", value);  // Imprime el último valor sin coma.
        }
        i += 1;  // Incrementa el índice.
    };
    println!(" ] }}");  // Cierra la estructura de impresión del array.
}