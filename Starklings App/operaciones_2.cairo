fn modulus(x: u8, y: u8) -> u8 {
    // Calcula el módulo (resto de la división) entre x e y
    let res = x % y; // usa el operador % para obtener el módulo
    res // devuelve el resultado
}

fn floor_division(x: usize, y: usize) -> usize {
    // Calcula la división entera entre x e y
    let res = x / y; // usa el operador / para la división entera
    res // devuelve el resultado
}

fn multiplication(x: u64, y: u64) -> u64 {
    // Calcula la multiplicación entre x e y
    let res = x * y; // usa el operador * para la multiplicación
    res // devuelve el resultado
}


// No cambiar las pruebas
#[test]
fn test_modulus() {
    let res = modulus(16, 2);
    assert(res == 0, 'Error message'); // 16 % 2 == 0

    let res = modulus(17, 3);
    assert(res == 2, 'Error message'); // 17 % 3 == 2
}

#[test]
fn test_floor_division() {
    let res = floor_division(160, 2);
    assert(res == 80, 'Error message'); // 160 / 2 == 80

    let res = floor_division(21, 4);
    assert(res == 5, 'Error message'); // 21 / 4 == 5 (división entera)
}

#[test]
fn test_mul() {
    let res = multiplication(16, 2);
    assert(res == 32, 'Error message'); // 16 * 2 == 32

    let res = multiplication(21, 4);
    assert(res == 84, 'Error message'); // 21 * 4 == 84
}

#[test]
#[should_panic]
fn test_u64_mul_overflow_1() {
    let _res = multiplication(0x100000000, 0x100000000); // esta multiplicación produce un overflow en u64
}