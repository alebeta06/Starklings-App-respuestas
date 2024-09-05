fn sum_u8s(x: u8, y: u8) -> u8 {
    // Esta función toma dos números u8 y los suma, devolviendo el resultado.
    x + y
}

// Cambié los tipos de u16 a u32 para evitar el desbordamiento.
// Con u16, si el resultado de la suma excede el rango de u16 (0-65535), se producirá un desbordamiento.
// Con u32, se puede manejar un rango mucho mayor.
fn sum_big_numbers(x: u32, y: u32) -> u32 {
    x + y
}

fn convert_to_felt(x: u8) -> felt252 {
    // Convierte un número u8 a felt252 usando el método `.into()`, que es un tipo más grande y adecuado para operaciones en Cairo.
    x.into()
}

fn convert_felt_to_u8(x: felt252) -> u8 {
    // Convierte un felt252 de vuelta a u8. Usamos `.try_into().unwrap()` para manejar la conversión, donde `unwrap()` asume que la conversión no fallará.
    x.try_into().unwrap()
}

// Pruebas para verificar el correcto funcionamiento de las funciones

#[test]
fn test_sum_u8s() {
    // Verifica si la suma de 1 y 2 como u8 devuelve 3.
    assert(sum_u8s(1, 2_u8) == 3_u8, 'Something went wrong');
}

#[test]
fn test_sum_big_numbers() {
    // Cambié los tipos a u32 para que coincidan con la nueva definición de la función y evitar desbordamientos.
    assert(sum_big_numbers(255_u32, 255_u32) == 510_u32, 'Something went wrong');
}

#[test]
fn test_convert_to_felt() {
    // Verifica si la conversión de u8 a felt252 es correcta.
    assert(convert_to_felt(1_u8) == 1, 'Type conversion went wrong');
}

#[test]
fn test_convert_to_u8() {
    // Verifica si la conversión de felt252 a u8 es correcta.
    assert(convert_felt_to_u8(1) == 1_u8, 'Type conversion went wrong');
}