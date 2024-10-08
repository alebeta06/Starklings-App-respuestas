#[starknet::interface]
trait IContractA<TContractState> {
    // Define la interfaz del contrato A. Las funciones permiten establecer y obtener un valor.
    fn set_value(ref self: TContractState, value: u128) -> bool; // Devuelve true si el valor se establece correctamente.
    fn get_value(self: @TContractState) -> u128; // Devuelve el valor almacenado.
}

#[starknet::contract]
mod ContractA {
    use starknet::ContractAddress;
    use super::IContractBDispatcher; // Interfaz para interactuar con ContractB.
    use super::IContractBDispatcherTrait; // Métodos definidos en la interfaz.

    #[storage]
    struct Storage {
        // Almacena la dirección del contrato B y el valor actual.
        contract_b: ContractAddress,
        value: u128,
    }

    #[constructor]
    // El constructor inicializa el contrato A y establece la dirección de ContractB.
    fn constructor(ref self: ContractState, contract_b: ContractAddress) {
        self.contract_b.write(contract_b) // Guarda la dirección de ContractB.
    }

    #[abi(embed_v0)]
    impl ContractAImpl of super::IContractA<ContractState> {
        fn set_value(ref self: ContractState, value: u128) -> bool {
            // Interactúa con ContractB para verificar si está habilitado.
            // Si está habilitado, actualiza el valor en ContractA.
            let contract_b = IContractBDispatcher { contract_address: self.contract_b.read() };
            if contract_b.is_enabled() {
                self.value.write(value); // Establece el nuevo valor.
                return true; // Devuelve true si se pudo establecer.
            }
            return false; // Si ContractB no está habilitado, devuelve false.
        }

        fn get_value(self: @ContractState) -> u128 {
            // Devuelve el valor almacenado en ContractA.
            self.value.read()
        }
    }
}

#[starknet::interface]
trait IContractB<TContractState> {
    // Define la interfaz para ContractB, con funciones para habilitar/deshabilitar y verificar si está habilitado.
    fn enable(ref self: TContractState); 
    fn disable(ref self: TContractState);
    fn is_enabled(self: @TContractState) -> bool; // Devuelve true si está habilitado.
}

#[starknet::contract]
mod ContractB {
    #[storage]
    struct Storage {
        // Almacena un booleano que indica si el contrato está habilitado o no.
        enabled: bool
    }

    #[constructor]
    // Constructor vacío, por defecto no hace nada.
    fn constructor(ref self: ContractState) {}

    #[abi(embed_v0)]
    impl ContractBImpl of super::IContractB<ContractState> {
        fn enable(ref self: ContractState) {
            // Habilita el contrato estableciendo `enabled` en true.
            self.enabled.write(true);
        }

        fn disable(ref self: ContractState) {
            // Deshabilita el contrato estableciendo `enabled` en false.
            self.enabled.write(false);
        }

        fn is_enabled(self: @ContractState) -> bool {
            // Devuelve el valor de `enabled` (true si está habilitado).
            self.enabled.read()
        }
    }
}

#[cfg(test)]
mod test {
    use starknet::syscalls::deploy_syscall; // Función para desplegar contratos.
    use starknet::ContractAddress;
    use super::ContractA;
    use super::IContractADispatcher;
    use super::IContractADispatcherTrait;
    use super::ContractB;
    use super::IContractBDispatcher;
    use super::IContractBDispatcherTrait;

    #[test]
    #[available_gas(30000000)]
    fn test_interoperability() {
        // Despliega el contrato B.
        let (address_b, _) = deploy_syscall(
            ContractB::TEST_CLASS_HASH.try_into().unwrap(), 0, ArrayTrait::new().span(), false
        )
            .unwrap();

        // Despliega el contrato A, pasando la dirección de ContractB en los argumentos.
        let mut calldata = ArrayTrait::new();
        calldata.append(address_b.into());
        let (address_a, _) = deploy_syscall(
            ContractA::TEST_CLASS_HASH.try_into().unwrap(), 0, calldata.span(), false
        )
            .unwrap();

        // `contract_a` es de tipo `IContractADispatcher`, y se usa para interactuar con ContractA.
        let contract_a = IContractADispatcher { contract_address: address_a };
        let contract_b = IContractBDispatcher { contract_address: address_b };

        // Habilita el contrato B para que se pueda establecer el valor en ContractA.
        contract_b.enable();

        // Verifica si se puede establecer el valor y luego lo comprueba.
        assert(contract_a.set_value(300) == true, 'Could not set value');
        assert(contract_a.get_value() == 300, 'Value was not set');
        assert(contract_b.is_enabled() == true, 'Contract b is not enabled');
    }
}
