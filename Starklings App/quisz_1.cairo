// Función que calcula el precio de las manzanas
fn calculate_price_of_apples(quantity: u32) -> u32 {
    if quantity > 40 {
        quantity * 2  // Si compra más de 40 manzanas, cada una cuesta 2 Cairobucks
    } else {
        quantity * 3  // Si compra 40 o menos, cada manzana cuesta 3 Cairobucks
    }
}

// No cambiar esta función de prueba
#[test]
fn verify_test() {
    let price1 = calculate_price_of_apples(35);
    let price2 = calculate_price_of_apples(40);
    let price3 = calculate_price_of_apples(41);
    let price4 = calculate_price_of_apples(65);

    assert(105 == price1, 'Incorrect price');
    assert(120 == price2, 'Incorrect price');
    assert(82 == price3, 'Incorrect price');
    assert(130 == price4, 'Incorrect price');
}