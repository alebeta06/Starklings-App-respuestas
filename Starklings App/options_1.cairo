// Esta función determina cuántos helados quedan basados en la hora del día.
// Si es antes de las 10PM (22:00 en formato de 24 horas), aún quedan 5 helados.
// Después de las 10PM, ya no quedan más helados.
fn maybe_icecream(time_of_day: usize) -> Option<usize> {
    // Si la hora es antes de las 22:00
    if time_of_day < 22 {
        Option::Some(5)  // Si es antes de las 10PM, devuelve 5 helados.
    } else if time_of_day > 23 {
        Option::None  // Si la hora es mayor que 23 (hora inválida), devuelve None.
    } else {
        Option::Some(0)  // Si es exactamente a las 22:00 o más tarde, no hay helados.
    }
}

#[test]
fn check_icecream() {
    // Verifica cuántos helados quedan a diferentes horas del día.
    assert(maybe_icecream(9).unwrap() == 5, 'err_1');  // A las 9AM, deben quedar 5 helados.
    assert(maybe_icecream(10).unwrap() == 5, 'err_2');  // A las 10AM, también quedan 5 helados.
    assert(maybe_icecream(23).unwrap() == 0, 'err_3');  // A las 11PM, no quedan helados.
    assert(maybe_icecream(22).unwrap() == 0, 'err_4');  // A las 10PM, no quedan helados.
    assert(maybe_icecream(25).is_none(), 'err_5');  // Si la hora es mayor que 23, devuelve None (hora inválida).
}

#[test]
fn raw_value() {
    // Esta prueba accede al valor dentro del Option y verifica si el resultado es correcto.
    // Se usa unwrap() para acceder directamente al valor dentro del Option.
    let icecreams = maybe_icecream(12).unwrap();  // Esperamos que a las 12PM queden 5 helados.
    assert(icecreams == 5, 'err_6');  // Verifica que el valor devuelto sea 5.
}