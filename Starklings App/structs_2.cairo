#[derive(Copy, Drop)]
struct Order {
    // Estructura que representa un pedido con diferentes campos de información
    name: felt252,            // Nombre del cliente o persona asociada al pedido
    year: felt252,            // Año en que se realizó el pedido
    made_by_phone: bool,      // Booleano que indica si el pedido se hizo por teléfono
    made_by_mobile: bool,     // Booleano que indica si el pedido se hizo por móvil
    made_by_email: bool,      // Booleano que indica si el pedido se hizo por email
    item_number: felt252,     // Número del artículo pedido
    count: felt252,           // Cantidad de artículos en el pedido
}

fn create_order_template() -> Order {
    // Función que crea una plantilla de pedido con valores predeterminados
    Order {
        name: 'Bob',                // El nombre del cliente es 'Bob'
        year: 2019,                 // Año del pedido: 2019
        made_by_phone: false,       // El pedido no fue hecho por teléfono
        made_by_mobile: false,      // El pedido no fue hecho por móvil
        made_by_email: true,        // El pedido fue hecho por email
        item_number: 123,           // Número del artículo es 123
        count: 0                    // Inicialmente, la cantidad de artículos es 0
    }
}

#[test]
fn test_your_order() {
    let order_template = create_order_template(); // Se crea un pedido basado en la plantilla

    // Desestructuración del pedido en variables individuales para hacer las comprobaciones
    let Order {
        name,
        year,
        made_by_phone,
        made_by_mobile,
        made_by_email,
        item_number,
        count,
    } = order_template;

    // Comprobaciones para verificar si los valores coinciden con los esperados
    assert(name == 'Bob', 'Wrong name');                   // El nombre debe ser 'Bob'
    assert(year == order_template.year, 'Wrong year');     // El año debe ser 2019
    assert(made_by_phone == order_template.made_by_phone, 'Wrong phone');  // El pedido no se hizo por teléfono
    assert(made_by_mobile == order_template.made_by_mobile, 'Wrong mobile');  // El pedido no se hizo por móvil
    assert(made_by_email == order_template.made_by_email, 'Wrong email');  // El pedido se hizo por email
    assert(item_number == order_template.item_number, 'Wrong item number');  // El número de artículo es 123
    assert(count == 0, 'Wrong count');                    // La cantidad de artículos es 0
}