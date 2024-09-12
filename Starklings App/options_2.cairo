#[test]
fn test_options() {
    // Declaramos una variable target que contiene la cadena 'starklings'.
    let target = 'starklings';
    
    // `optional_some` es una variante de Option que contiene el valor 'starklings'.
    let optional_some = Option::Some(target);
    
    // `optional_none` es una variante de Option que representa la ausencia de un valor (None).
    let optional_none: Option<felt252> = Option::None;
    
    // Llamamos a la función `simple_option` con ambos valores de Option.
    simple_option(optional_some);
    simple_option(optional_none);
}

fn simple_option(optional_target: Option<felt252>) {
    // Esta función verifica si `optional_target` contiene un valor (Some) o no (None).

    // Verificamos si `optional_target` tiene un valor.
    if optional_target.is_some() {
        // Si contiene un valor, se asegura de que sea igual a 'starklings'.
        assert(optional_target.unwrap() == 'starklings', 'err1');
    } else if optional_target.is_none() {
        // Si no contiene un valor, imprimimos un mensaje diciendo que la opción está vacía.
        println!(" option is empty ! ");
    }
}