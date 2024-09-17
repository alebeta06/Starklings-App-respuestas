#[derive(Copy, Drop)]
struct ColorStruct { 
    // Definimos una estructura que representa un color con tres componentes:
    // rojo (red), verde (green) y azul (blue), todas de tipo felt252.
    red: felt252,
    green: felt252,
    blue: felt252,
}

#[test]
fn classic_c_structs() {
    // TODO: Instanciamos un struct ColorStruct.
    // Creamos un color verde, donde el componente green está en 255, 
    // mientras que red y blue están en 0, lo que genera el color verde.
    let green = ColorStruct {red: 0, green: 255, blue: 0};

    // Aseguramos que el componente rojo es 0.
    assert(green.red == 0, 0);
    // Aseguramos que el componente verde es 255.
    assert(green.green == 255, 0);
    // Aseguramos que el componente azul es 0.
    assert(green.blue == 0, 0);
}