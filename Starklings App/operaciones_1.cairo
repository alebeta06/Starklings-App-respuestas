// Devuelve la solución de x^3 + y - 2

fn poly(x: usize, y: usize) -> usize {
    let res = (x * x * x) + y - 2; // Calcula x^3 + y - 2
    res // Retorna el resultado
}

#[test]
fn test_poly() {
    let res = poly(5, 3);
    assert(res == 126, 'Error message');    // Verifica que el resultado sea 126
    assert(res < 300, 'res < 300');         // Verifica que el resultado sea menor que 300
    assert(res <= 300, 'res <= 300');       // Verifica que el resultado sea menor o igual a 300
    assert(res > 20, 'res > 20');           // Verifica que el resultado sea mayor que 20
    assert(res >= 2, 'res >= 2');           // Verifica que el resultado sea mayor o igual a 2
    assert(res != 27, 'res != 27');         // Verifica que el resultado no sea igual a 27
    assert(res % 2 == 0, 'res % 2 != 0');   // Verifica que el resultado sea par
}