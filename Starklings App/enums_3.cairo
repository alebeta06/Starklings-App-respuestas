#[derive(Drop, Copy)]
enum Message { 
    // El enum `Message` define las variantes posibles de mensajes
    // Cada variante tiene un tipo de dato asociado como u8, felt252 o una estructura `Point`
    ChangeColor: (u8, u8, u8),  // Variante que contiene un color RGB (valores de 0-255)
    Echo: felt252,  // Variante que contiene una cadena (felt252)
    Move: Point,  // Variante que contiene una posición (struct `Point`)
    Quit,  // Variante que indica que se ha solicitado "salir"
}

#[derive(Drop, Copy)]
struct Point {
    // Estructura `Point` que representa una coordenada en el plano
    x: u8,  // Coordenada X
    y: u8,  // Coordenada Y
}

#[derive(Drop, Copy)]
struct State {
    // Estructura `State` que representa el estado actual de la aplicación
    color: (u8, u8, u8),  // Color actual (RGB)
    position: Point,  // Posición actual
    quit: bool,  // Indica si el estado es "quit" (salir)
}

trait StateTrait {
    // Definimos métodos asociados a la estructura `State`
    fn change_color(ref self: State, new_color: (u8, u8, u8));  // Cambiar color
    fn quit(ref self: State);  // Establecer el estado de "quit"
    fn echo(ref self: State, s: felt252);  // Mostrar un mensaje
    fn move_position(ref self: State, p: Point);  // Cambiar la posición
    fn process(ref self: State, message: Message);  // Procesar un mensaje
}

impl StateImpl of StateTrait {
    // Implementación del trait `StateTrait` para la estructura `State`
    
    fn change_color(ref self: State, new_color: (u8, u8, u8)) {
        // Actualiza el color en el estado
        let State { color: _, position, quit, } = self;
        self = State { color: new_color, position: position, quit: quit, };
    }
    
    fn quit(ref self: State) {
        // Cambia el estado de `quit` a `true`
        let State { color, position, quit: _, } = self;
        self = State { color: color, position: position, quit: true, };
    }

    fn echo(ref self: State, s: felt252) {
        // Imprime el mensaje `s`
        println!("{}", s);
    }

    fn move_position(ref self: State, p: Point) {
        // Actualiza la posición en el estado
        let State { color, position: _, quit, } = self;
        self = State { color: color, position: p, quit: quit, };
    }

    fn process(ref self: State, message: Message) {
        // Procesa el mensaje recibido y llama a la función correspondiente según la variante
        match message {
            Message::ChangeColor(new_color) => self.change_color(new_color),
            Message::Echo(value) => self.echo(value),
            Message::Move(Point {x,y}) => self.move_position(Point{x,y}),
            Message::Quit => self.quit(),
        }
    }
}

#[test]
fn test_match_message_call() {
    // Inicializamos el estado con color (0, 0, 0), posición (0, 0), y `quit` en `false`
    let mut state = State { quit: false, position: Point { x: 0, y: 0 }, color: (0, 0, 0), };
    
    // Procesamos varios mensajes y actualizamos el estado
    state.process(Message::ChangeColor((255, 0, 255)));  // Cambia color a RGB(255, 0, 255)
    state.process(Message::Echo('hello world'));  // Imprime "hello world"
    state.process(Message::Move(Point { x: 10, y: 15 }));  // Cambia la posición a (10, 15)
    state.process(Message::Quit);  // Cambia el estado `quit` a `true`

    // Verificamos que el estado se haya actualizado correctamente
    assert(state.color == (255, 0, 255), 'wrong color');
    assert(state.position.x == 10, 'wrong x position');
    assert(state.position.y == 15, 'wrong y position');
    assert(state.quit == true, 'quit should be true');
}
