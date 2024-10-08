use starknet::ContractAddress;

#[starknet::interface]
trait ILizInventory<TContractState> {
    // Define una interfaz para el contrato, que maneja las acciones de agregar stock,
    // comprar productos, obtener el stock disponible y obtener al propietario del contrato.
    fn add_stock(ref self: TContractState, product: felt252, new_stock: u32);
    fn purchase(ref self: TContractState, product: felt252, quantity: u32);
    fn get_stock(self: @TContractState, product: felt252) -> u32;
    fn get_owner(self: @TContractState) -> ContractAddress;
}

#[starknet::contract]
mod LizInventory {
    use starknet::ContractAddress;
    use starknet::get_caller_address;

    #[storage]
    struct Storage {
        // Definimos el propietario del contrato y un mapa que asocia productos (felt252)
        // con cantidades de stock (u32).
        contract_owner: ContractAddress,
        product_stock: LegacyMap<felt252, u32> // Inventario de productos y sus cantidades.
    }

    #[constructor]
    // Constructor del contrato, que establece el propietario inicial del contrato.
    fn constructor(ref self: ContractState, owner: ContractAddress) {
        self.contract_owner.write(owner);
    }

    #[abi(embed_v0)]
    impl LizInventoryImpl of super::ILizInventory<ContractState> {
        // Función para agregar stock. Solo el propietario del contrato puede realizar esta acción.
        fn add_stock(ref self: ContractState, product: felt252, new_stock: u32) {
            let caller = get_caller_address();
            let owner = self.contract_owner.read();
            // Verificamos que quien llama a la función sea el propietario.
            assert(caller == owner, 'Only owner can add stock');
            // Leemos el stock actual del producto y añadimos el nuevo stock.
            let stock = self.product_stock.read(product);
            self.product_stock.write(product, stock + new_stock);
        }

        // Función para comprar un producto, cualquiera puede realizar esta acción.
        fn purchase(ref self: ContractState, product: felt252, quantity: u32) {
            // Verificamos si hay suficiente stock para la cantidad deseada.
            let stock = self.product_stock.read(product);
            assert(stock >= quantity, 'Not enough stock');
            // Restamos la cantidad comprada del stock actual.
            self.product_stock.write(product, stock - quantity);
        }

        // Devuelve la cantidad de stock disponible para un producto específico.
        fn get_stock(self: @ContractState, product: felt252) -> u32 {
            self.product_stock.read(product)
        }

        // Devuelve la dirección del propietario del contrato.
        fn get_owner(self: @ContractState) -> ContractAddress {
            self.contract_owner.read()
        }
    }
}

#[cfg(test)]
mod test {
    use starknet::ContractAddress;
    use starknet::syscalls::deploy_syscall;
    use core::result::ResultTrait;
    use super::LizInventory;
    use super::ILizInventoryDispatcher;
    use super::ILizInventoryDispatcherTrait;

    #[test]
    #[available_gas(2000000000)]
    // Test para verificar que el propietario del contrato está correctamente configurado.
    fn test_owner() {
        let owner: ContractAddress = 'Elizabeth'.try_into().unwrap();
        let dispatcher = deploy_contract();

        // Verificamos si el propietario del contrato es 'Elizabeth'.
        let contract_owner = dispatcher.get_owner();
        assert(contract_owner == owner, 'Elizabeth should be the owner');
    }

    #[test]
    #[available_gas(2000000000)]
    // Test para verificar la adición de stock y el stock disponible después de la operación.
    fn test_stock() {
        let dispatcher = deploy_contract();
        let owner = util_felt_addr('Elizabeth');

        // Llamamos al contrato como el propietario.
        starknet::testing::set_contract_address(owner);

        // Añadimos stock al producto 'Nano'.
        dispatcher.add_stock('Nano', 10);
        let stock = dispatcher.get_stock('Nano');
        assert(stock == 10, 'stock should be 10');

        // Añadimos más stock al producto 'Nano' y verificamos el total.
        dispatcher.add_stock('Nano', 15);
        let stock = dispatcher.get_stock('Nano');
        assert(stock == 25, 'stock should be 25');
    }

    #[test]
    #[available_gas(2000000000)]
    // Test para verificar la compra de productos y la actualización del stock.
    fn test_stock_purchase() {
        let owner = util_felt_addr('Elizabeth');
        let dispatcher = deploy_contract();

        // Llamamos al contrato como propietario y añadimos stock.
        starknet::testing::set_contract_address(owner);
        dispatcher.add_stock('Nano', 10);

        let stock = dispatcher.get_stock('Nano');
        assert(stock == 10, 'stock should be 10');

        // Simulamos la compra de una cantidad del producto 'Nano'.
        starknet::testing::set_caller_address(0.try_into().unwrap());
        dispatcher.purchase('Nano', 2);

        let stock = dispatcher.get_stock('Nano');
        assert(stock == 8, 'stock should be 8');
    }

    #[test]
    #[should_panic]
    #[available_gas(2000000000)]
    // Test para verificar que si alguien no autorizado intenta agregar stock, falla.
    fn test_set_stock_fail() {
        let dispatcher = deploy_contract();
        dispatcher.add_stock('Nano', 20);
    }

    #[test]
    #[should_panic]
    #[available_gas(2000000000)]
    // Test para verificar la compra cuando no hay suficiente stock, lo que debe provocar un fallo.
    fn test_purchase_out_of_stock() {
        let dispatcher = deploy_contract();
        dispatcher.purchase('Nano', 2);
    }

    // Función auxiliar para convertir direcciones felt252 a ContractAddress.
    fn util_felt_addr(addr_felt: felt252) -> ContractAddress {
        addr_felt.try_into().unwrap()
    }

    // Despliega el contrato y retorna el dispatcher para interactuar con él.
    fn deploy_contract() -> ILizInventoryDispatcher {
        let owner: felt252 = 'Elizabeth';
        let mut calldata = ArrayTrait::new();
        calldata.append(owner);
        let (address0, _) = deploy_syscall(
            LizInventory::TEST_CLASS_HASH.try_into().unwrap(), 0, calldata.span(), false
        ).unwrap();
        let contract0 = ILizInventoryDispatcher { contract_address: address0 };
        contract0
    }
}
