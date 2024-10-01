use core::dict::{Felt252DictTrait, Felt252Dict}; 

#[derive(Destruct)]
struct Team {
    level: Felt252Dict<usize>, // El diccionario `level` almacena los niveles de los jugadores usando un tipo de dato clave `felt252` y valores `usize`.
    players_count: usize // Contador para llevar la cuenta de cuántos jugadores hay en el equipo.
}

#[generate_trait]
impl TeamImpl of TeamTrait {
    fn new() -> Team {
        // Inicializa un equipo vacío con 0 jugadores. El diccionario `level` se inicializa con un valor por defecto.
        Team {
            level: Default::default(),
            players_count: 0
        }
    }

    fn get_level(ref self: Team, name: felt252) -> usize {
        // Obtiene el nivel del jugador utilizando su nombre como clave en el diccionario `level`.
        self.level.get(name)
    }

    fn add_player(ref self: Team, name: felt252, level: usize) {
        // Agrega un jugador nuevo al equipo. Se almacena su nivel en el diccionario y se incrementa el contador de jugadores.
        self.level.insert(name, level);
        self.players_count += 1;
    }

    fn level_up(ref self: Team, name: felt252) {
        // Incrementa el nivel del jugador especificado. Primero obtiene el nivel actual y luego lo actualiza.
        let current_level = self.level.get(name);
        self.level.insert(name, current_level + 1);
    }

    fn players_count(self: @Team) -> usize {
        // Devuelve el número de jugadores en el equipo.
        self.players_count.clone()
    }
}

#[test]
#[available_gas(200000)]
fn test_add_player() {
    // Prueba para verificar que se pueden agregar jugadores correctamente.
    let mut team = TeamTrait::new(); // Crea un nuevo equipo.
    team.add_player('bob', 10); // Agrega un jugador llamado 'bob' con nivel 10.
    team.add_player('alice', 20); // Agrega un jugador llamado 'alice' con nivel 20.

    // Verifica que se hayan agregado dos jugadores y que sus niveles sean correctos.
    assert(team.players_count == 2, 'Wrong number of player');
    assert(team.get_level('bob') == 10, 'Wrong level');
    assert(team.get_level('alice') == 20, 'Wrong level');
}

#[test]
#[available_gas(200000)]
fn test_level_up() {
    // Prueba para verificar que la función `level_up` aumenta correctamente el nivel de un jugador.
    let mut team = TeamTrait::new(); // Crea un nuevo equipo.
    team.add_player('bobby', 10); // Agrega un jugador llamado 'bobby' con nivel 10.
    team.level_up('bobby'); // Aumenta el nivel de 'bobby' en 1.

    // Verifica que el nivel de 'bobby' sea ahora 11.
    assert(team.level.get('bobby') == 11, 'Wrong level');
}
