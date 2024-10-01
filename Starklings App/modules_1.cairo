mod restaurant {
    // Esta función pública `take_order` simula el proceso de tomar una orden en el módulo `restaurant`.
    pub fn take_order() -> felt252 {
        'order_taken' // Retorna un mensaje indicando que la orden fue tomada.
    }
}

#[test]
fn test_mod_fn() {
    // Llamada correcta a la función `take_order` desde el módulo `restaurant`.
    let order_result = restaurant::take_order();

    // Verifica que la función retorne el mensaje correcto.
    assert(order_result == 'order_taken', 'Order not taken');
}

#[cfg(test)]
mod tests {
    #[test]
    fn test_super_fn() {
        // Llamada correcta a la función `take_order` utilizando la referencia `super`, que accede al módulo externo.
        let order_result = super::restaurant::take_order();

        // Verifica que la función retorne el mensaje esperado.
        assert(order_result == 'order_taken', 'Order not taken');
    }
}
