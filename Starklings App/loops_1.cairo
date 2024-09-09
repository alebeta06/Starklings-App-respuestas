#[test]
#[available_gas(200000)]
fn test_loop() {
    let mut counter = 0;
    // Agregar una condición para que el loop continúe hasta que el contador sea 10
    loop {
        if counter == 10 {
            break ();
        }
        counter += 1;
    };
    assert(counter == 10, 'counter should be 10');
}