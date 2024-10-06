use starknet::ContractAddress;

#[starknet::contract]
mod JillsContract {
    // Importamos el tipo `ContractAddress` que nos permite manejar direcciones de contratos en Starknet.
    use starknet::ContractAddress;

    #[storage]
    // Definimos la estructura de almacenamiento del contrato.
    // Añadimos una variable `owner` que almacenará la dirección del propietario del contrato.
    struct Storage { 
        owner: ContractAddress,  // Almacena la dirección del propietario del contrato.
    }

    #[constructor]
    // Esta función se ejecuta una vez al desplegar el contrato.
    // Recibe una referencia al estado del contrato (`ContractState`) y la dirección del propietario (`owner`).
    // Escribe la dirección del propietario en el almacenamiento del contrato.
    fn constructor(
        ref self: ContractState, owner: ContractAddress
    ) { 
        self.owner.write(owner);  // Escribimos la dirección del propietario en el almacenamiento.
    }

    #[abi(embed_v0)]
    impl IJillsContractImpl of super::IJillsContract<ContractState> {
        // Implementa la función `get_owner` que permite leer la dirección del propietario almacenada.
        fn get_owner(self: @ContractState) -> ContractAddress {
            self.owner.read()  // Leemos la dirección del propietario desde el almacenamiento.
        }
    }
}

#[starknet::interface]
trait IJillsContract<TContractState> {
    // Esta interfaz define una función `get_owner` que será implementada por el contrato.
    // Permite a los usuarios obtener la dirección del propietario del contrato.
    fn get_owner(self: @TContractState) -> ContractAddress;
}

#[cfg(test)]
mod test {
    use starknet::ContractAddress;
    use starknet::syscalls::deploy_syscall;  // Importa la función para desplegar el contrato en Starknet.
    use super::JillsContract;
    use super::IJillsContractDispatcher;
    use super::IJillsContractDispatcherTrait;

    #[test]
    #[available_gas(2000000000)]
    fn test_owner_setting() {
        let mut calldata = ArrayTrait::new();
        calldata.append('Jill');  // Añadimos el nombre del propietario al calldata.
        
        // Desplegamos el contrato y obtenemos la dirección de despliegue.
        let (address0, _) = deploy_syscall(
            JillsContract::TEST_CLASS_HASH.try_into().unwrap(), 0, calldata.span(), false
        )
        .unwrap();

        // Instanciamos un dispatcher para interactuar con el contrato.
        let dispatcher = IJillsContractDispatcher { contract_address: address0 };

        // Obtenemos la dirección del propietario almacenada en el contrato.
        let owner = dispatcher.get_owner();

        // Verificamos que la dirección del propietario sea 'Jill'.
        assert(owner == 'Jill'.try_into().unwrap(), 'Owner should be Jill');
    }
}
