 #[starknet::interface]
trait IJoesContract<TContractState> {
    // Define una interfaz de contrato inteligente `IJoesContract`.
    // `get_owner` es una función pública que devuelve el propietario del contrato.
    fn get_owner(self: @TContractState) -> felt252;
}

#[starknet::contract]
mod JoesContract {    
    use super::IJoesContract;  // Importa la interfaz definida anteriormente.

    #[storage]
    // Estructura de almacenamiento del contrato que define la variable `owner`, donde se almacena el propietario del contrato.
    struct Storage {
        owner: felt252,
    }

    #[constructor]
    // Función especial que se ejecuta una vez al implementar el contrato.
    // Inicializa el propietario del contrato como 'Joe'.
    fn constructor(ref self: ContractState) {
        self.owner.write('Joe');  // Escribe el valor 'Joe' en el almacenamiento como propietario.
    }

    #[abi(embed_v0)]
    impl IJoesContractImpl of IJoesContract<ContractState> {
        // Implementa la interfaz `IJoesContract` y define la función `get_owner`.
        // Esta función devuelve el propietario del contrato desde el almacenamiento.
        fn get_owner(self: @ContractState) -> felt252 {
            self.owner.read()  // Lee y devuelve el valor del propietario.
        }
    }
}

#[cfg(test)]
mod test {
    use starknet::syscalls::deploy_syscall;
    use starknet::ContractAddress;
    use super::JoesContract;  // Importa el contrato `JoesContract` para ser probado.
    use super::IJoesContractDispatcher;
    use super::IJoesContractDispatcherTrait;

    #[test]
    #[available_gas(2000000000)]
    // Prueba unitaria para verificar la función `get_owner`.
    fn test_contract_view() {
        let dispatcher = deploy_contract();
        // Verifica que el propietario devuelto por `get_owner` sea 'Joe'.
        assert('Joe' == dispatcher.get_owner(), 'Joe should be the owner.');
    }

    fn deploy_contract() -> IJoesContractDispatcher {
        let mut calldata = ArrayTrait::new();  // Crea un array vacío como calldata.
        let (address0, _) = deploy_syscall(
            JoesContract::TEST_CLASS_HASH.try_into().unwrap(), 0, calldata.span(), false
        )
            .unwrap();
        // Crea una instancia de `IJoesContractDispatcher` con la dirección del contrato.
        let contract0 = IJoesContractDispatcher { contract_address: address0 };
        contract0
    }
}
