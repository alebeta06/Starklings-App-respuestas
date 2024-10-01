const YEAR: u16 = 2050;  // Definimos una constante `YEAR` para almacenar el año 2050.

mod order {
    #[derive(Copy, Drop)]
    // Definimos una estructura `Order` que representa una orden de compra.
    // Incluye campos como el nombre del cliente, el año de la orden, si se hizo por teléfono o email, y el ítem.
    pub struct Order {
        name: felt252,  // Nombre del cliente.
        year: u16,  // Año de la orden (usa la constante YEAR del módulo superior).
        pub made_by_phone: bool,  // Indica si la orden fue realizada por teléfono.
        made_by_email: bool,  // Indica si la orden fue realizada por email.
        item: felt252,  // Producto o ítem de la orden.
    }

    // Función pública para crear una nueva orden. Si se hace por teléfono, `made_by_email` será falso, y viceversa.
    pub fn new_order(name: felt252, made_by_phone: bool, item: felt252) -> Order {
        Order { 
            name, 
            year: super::YEAR,  // Usa la constante `YEAR` del módulo superior.
            made_by_phone, 
            made_by_email: !made_by_phone,  // Si la orden no fue hecha por teléfono, fue por email.
            item,  
        }
    }
}

mod order_utils {
    // Función para crear una orden falsa hecha por teléfono.
    pub fn dummy_phoned_order(name: felt252) -> super::order::Order {
        super::order::new_order(name, true, 'item_a')  // Llama a `new_order` con `made_by_phone = true`.
    }

    // Función para crear una orden falsa hecha por email.
    pub fn dummy_emailed_order(name: felt252) -> super::order::Order {
        super::order::new_order(name, false, 'item_a')  // Llama a `new_order` con `made_by_phone = false`.
    }

    // Calcula las tarifas de la orden. Si la orden fue realizada por teléfono, cuesta 500, sino 200.
    pub fn order_fees(order: super::order::Order) -> felt252 {
        if order.made_by_phone {
            return 500;  // Si la orden fue hecha por teléfono, la tarifa es 500.
        }

        200  // Si fue hecha por email, la tarifa es 200.
    }
}

#[test]
fn test_array() {
    // Prueba que valida la tarifa de una orden hecha por teléfono.
    let order1 = order_utils::dummy_phoned_order('John Doe');
    let fees1 = order_utils::order_fees(order1);
    assert(fees1 == 500, 'Order fee should be 500');  // La tarifa debería ser 500.

    // Prueba que valida la tarifa de una orden hecha por email.
    let order2 = order_utils::dummy_emailed_order('Jane Doe');
    let fees2 = order_utils::order_fees(order2);
    assert(fees2 == 200, 'Order fee should be 200');  // La tarifa debería ser 200.
}
