#[derive(Copy, Drop)]
struct Package {
    // La estructura Package almacena la información sobre el paquete.
    sender_country: felt252,        // País de origen del paquete.
    recipient_country: felt252,     // País de destino del paquete.
    weight_in_grams: usize,         // Peso del paquete en gramos.
}

trait PackageTrait {
    // Definimos el trait que contiene las funciones asociadas a la estructura Package.
    fn new(sender_country: felt252, recipient_country: felt252, weight_in_grams: usize) -> Package;
    fn is_international(ref self: Package) -> bool;  // Función que determina si el envío es internacional.
    fn get_fees(ref self: Package, cents_per_gram: usize) -> u32;  // Calcula las tarifas de envío basadas en el peso.
}

impl PackageImpl of PackageTrait {
    // Constructor que crea un paquete, validando que el peso sea mayor a 0.
    fn new(sender_country: felt252, recipient_country: felt252, weight_in_grams: usize) -> Package {
        if weight_in_grams <= 0{
            let mut data = ArrayTrait::new();
            data.append('x');   // Si el peso es 0 o negativo, lanza un panic.
            panic(data);
        }
        Package { sender_country, recipient_country, weight_in_grams, }
    }

    // Determina si el paquete es internacional (si el país de origen es diferente al de destino).
    fn is_international(ref self: Package) -> bool {
        if self.sender_country != self.recipient_country {
            return true;  // Es internacional si los países son distintos.
        } else {
            return false;  // No es internacional si los países son iguales.
        }
    }

    // Calcula las tarifas multiplicando el peso por el costo en centavos por gramo.
    fn get_fees(ref self: Package, cents_per_gram: usize) -> u32 {
        return self.weight_in_grams * cents_per_gram;
    }
}

#[test]
#[should_panic]
fn fail_creating_weightless_package() {
    // Prueba que genera un error al intentar crear un paquete con peso 0.
    let sender_country = 'Spain';
    let recipient_country = 'Austria';
    PackageTrait::new(sender_country, recipient_country, 0);
}

#[test]
fn create_international_package() {
    // Crea un paquete internacional entre España y Rusia, y verifica que sea internacional.
    let sender_country = 'Spain';
    let recipient_country = 'Russia';

    let mut package = PackageTrait::new(sender_country, recipient_country, 1200);

    assert(package.is_international() == true, 'Not international');
}

#[test]
fn create_local_package() {
    // Crea un paquete local (enviador y receptor en el mismo país), y verifica que no sea internacional.
    let sender_country = 'Canada';
    let recipient_country = sender_country;

    let mut package = PackageTrait::new(sender_country, recipient_country, 1200);

    assert(package.is_international() == false, 'International');
}

#[test]
fn calculate_transport_fees() {
    // Calcula las tarifas de transporte en función del peso y el costo por gramo.
    let sender_country = 'Spain';
    let recipient_country = 'Spain';

    let cents_per_gram = 3;

    let mut package = PackageTrait::new(sender_country, recipient_country, 1500);

    assert(package.get_fees(cents_per_gram) == 4500, 'Wrong fees');  // Verifica si las tarifas calculadas son correctas.
}