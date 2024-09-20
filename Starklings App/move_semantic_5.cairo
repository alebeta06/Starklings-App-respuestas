#[test] 
fn main() {
    let mut a = ArrayTrait::new();  // Se crea un array vacío de tipo felt252.
    pass_by_ref(ref a);  // Se pasa el array por referencia (mutable).
    pass_by_snapshot(@a);  // Se pasa una "instantánea" o snapshot del array, es decir, una copia sin modificar el original.
    let mut b = pass_by_value(a);  // Se pasa el array por valor. Esto significa que `a` ya no será accesible después de esta línea.
    pass_by_ref(ref b);  // Se pasa por referencia el nuevo array `b`.
}

// Esta función toma un array por valor. Al pasar por valor, se crea una copia del array para modificarla sin afectar al original.
fn pass_by_value(mut arr: Array<felt252>) -> Array<felt252> {
    arr  // Se retorna el array después de posiblemente haber sido modificado.
}

// Esta función toma un array por referencia. Esto permite modificar el array original sin crear una copia.
fn pass_by_ref(ref arr: Array<felt252>) {}

// Esta función toma una instantánea o snapshot del array. Esto significa que puede leer el estado del array pero no puede modificarlo.
fn pass_by_snapshot(x: @Array<felt252>) {}