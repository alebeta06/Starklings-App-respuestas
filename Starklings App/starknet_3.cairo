use starknet::ContractAddress;

#[starknet::interface]
trait IProgressTracker<TContractState> {
    // Define las funciones públicas que manejarán el progreso de los usuarios y
    // obtendrán al propietario del contrato.
    fn set_progress(ref self: TContractState, user: ContractAddress, new_progress: u16);
    fn get_progress(self: @TContractState, user: ContractAddress) -> u16;
    fn get_contract_owner(self: @TContractState) -> ContractAddress;
}

#[starknet::contract]
mod ProgressTracker {
    use starknet::ContractAddress;
    use starknet::get_caller_address; // Importa la función para obtener la dirección del llamador.

    #[storage]
    struct Storage {
        // Almacenamos la dirección del propietario del contrato y el progreso de los usuarios.
        contract_owner: ContractAddress,
        progress: LegacyMap<ContractAddress, u16> // Mapa para almacenar el progreso por dirección.
    }

    #[constructor]
    // Constructor que se ejecuta cuando se despliega el contrato.
    // Asigna al propietario del contrato al desplegarlo.
    fn constructor(ref self: ContractState, owner: ContractAddress) {
        self.contract_owner.write(owner);
    }

    #[abi(embed_v0)]
    impl ProgressTrackerImpl of super::IProgressTracker<ContractState> {
        // Función para establecer el progreso de un usuario. Solo puede ser llamada por el propietario.
        fn set_progress(
            ref self: ContractState, user: ContractAddress, new_progress: u16
        ) {
            let caller = get_caller_address(); // Obtiene la dirección del que llama a la función.
            // Verifica si el llamador es el propietario del contrato.
            assert(caller == self.get_contract_owner(), 'Only the owner can set progress');
            // Actualiza el progreso del usuario.
            self.progress.write(user, new_progress);
        }

        // Función para obtener el progreso de un usuario.
        fn get_progress(self: @ContractState, user: ContractAddress) -> u16 {
            self.progress.read(user) // Lee el progreso almacenado del usuario.
        }

        // Función para obtener la dirección del propietario del contrato.
        fn get_contract_owner(self: @ContractState) -> ContractAddress {
            self.contract_owner.read() // Lee la dirección del propietario.
        }
    }
}

#[cfg(test)]
mod test {
    use starknet::ContractAddress;
    use starknet::syscalls::deploy_syscall;
    use super::ProgressTracker;
    use super::IProgressTrackerDispatcher;
    use super::IProgressTrackerDispatcherTrait;

    #[test]
    #[available_gas(2000000000)]
    fn test_owner() {
        // Se define una dirección como propietario y se despliega el contrato.
        let owner: ContractAddress = 'Sensei'.try_into().unwrap();
        let dispatcher = deploy_contract();
        // Verifica si el propietario es correcto.
        assert(owner == dispatcher.get_contract_owner(), 'Mr. Sensei should be the owner');
    }

    #[test]
    #[available_gas(2000000000)]
    fn test_set_progress() {
        // Despliega el contrato y asigna el propietario.
        let owner = util_felt_addr('Sensei');
        let dispatcher = deploy_contract();

        // Llama al contrato como el propietario.
        starknet::testing::set_contract_address(owner);

        // Establece el progreso para dos usuarios.
        dispatcher.set_progress('Joe'.try_into().unwrap(), 20);
        dispatcher.set_progress('Jill'.try_into().unwrap(), 25);

        // Verifica si el progreso establecido es correcto.
        let joe_score = dispatcher.get_progress('Joe'.try_into().unwrap());
        assert(joe_score == 20, 'Joe\'s progress should be 20');
    }

    #[test]
    #[should_panic]
    #[available_gas(2000000000)]
    fn test_set_progress_fail() {
        let dispatcher = deploy_contract();

        let jon_doe = util_felt_addr('JonDoe');
        // Llama al contrato con un usuario que no es el propietario.
        starknet::testing::set_contract_address(jon_doe);

        // Intenta establecer progreso, lo que debería fallar (pánico).
        dispatcher.set_progress('Joe'.try_into().unwrap(), 20);
    }

    fn util_felt_addr(addr_felt: felt252) -> ContractAddress {
        addr_felt.try_into().unwrap() // Convierte una dirección felt252 en ContractAddress.
    }

    fn deploy_contract() -> IProgressTrackerDispatcher {
        let owner: felt252 = 'Sensei';
        let mut calldata = ArrayTrait::new(); // Crea un array de datos de entrada para el contrato.
        calldata.append(owner);
        let (address0, _) = deploy_syscall(
            ProgressTracker::TEST_CLASS_HASH.try_into().unwrap(), 0, calldata.span(), false
        )
        .unwrap(); // Despliega el contrato y obtiene su dirección.
        let contract0 = IProgressTrackerDispatcher { contract_address: address0 }; // Crea un dispatcher para interactuar con el contrato.
        contract0
    }
}