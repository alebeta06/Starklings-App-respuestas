use core::fmt::{Display, Formatter, Error};

// Definimos un enumerado `Message` con variantes que representan diferentes tipos de mensajes.
// Algunas variantes no contienen datos, mientras que otras incluyen datos como cadenas o tuplas.
#[derive(Copy, Drop)]
enum Message {
    Quit,                           // Variante sin datos, representa una acción de salida.
    Echo: felt252,                  // Variante con un `felt252`, representa un mensaje de eco.
    Move: (u32, u32),               // Variante con tupla `(u32, u32)`, representa un movimiento en coordenadas.
    ChangeColor: (u8, u8, u8),      // Variante con tupla `(u8, u8, u8)`, representa un cambio de color (RGB).
}    


fn main() { // Función principal que ejecuta la lógica del contrato.
    let mut messages: Array<Message> = ArrayTrait::new(); // Inicializamos un array de mensajes.

    // Agregamos diferentes variantes del enum `Message` al array.
    messages.append(Message::Quit);                    // Variante `Quit`.
    messages.append(Message::Echo('hello world'));     // Variante `Echo` con mensaje 'hello world'.
    messages.append(Message::Move((10, 30)));          // Variante `Move` con coordenadas (10, 30).
    messages.append(Message::ChangeColor((0, 255, 255))); // Variante `ChangeColor` con color RGB (0, 255, 255).

    // Llamamos a la función recursiva para imprimir todos los mensajes.
    print_messages_recursive(messages, 0)
}

// Definimos un trait llamado `MessageTrait` que tendrá un método `call`.
trait MessageTrait<T> {
    fn call(self: T);
}

// Implementamos el trait `MessageTrait` para la variante `Message`.
// Este método imprime la representación del mensaje.
impl MessageImpl of MessageTrait<Message> {
    fn call(self: Message) {
        println!("{}", self);  // Imprime el mensaje usando el trait `Display`.
    }
}

// Función recursiva que imprime cada mensaje del array `messages`.
fn print_messages_recursive(messages: Array<Message>, index: u32) {
    if index >= messages.len() { // Si el índice supera el tamaño del array, termina la recursión.
        return (); 
    }
    let message = *messages.at(index); // Obtiene el mensaje en el índice actual.
    message.call();                    // Llama a `call()` para imprimir el mensaje.
    print_messages_recursive(messages, index + 1) // Llama recursivamente a la función con el siguiente índice.
}

// Implementamos el trait `Display` para el tipo `Message` para formatear su representación como cadena.
impl MessageDisplay of Display<Message> {
    fn fmt(self: @Message, ref f: Formatter) -> Result<(), Error> {
        println!("___MESSAGE BEGINS___"); // Imprime un delimitador inicial.
        // Formateamos la representación del mensaje dependiendo de la variante del enum.
        let str: ByteArray = match self {
            Message::Quit => format!("Quit"), // Variante `Quit` sin datos.
            Message::Echo(msg) => format!("{}", msg), // Variante `Echo` con un mensaje.
            Message::Move((a, b)) => { // Variante `Move` con coordenadas.
                format!("{} {}", a, b)
            },
            Message::ChangeColor((red, green, blue)) => { // Variante `ChangeColor` con valores RGB.
                format!("{} {} {}", red, green, blue)
            }
        };
        f.buffer.append(@str); // Agrega la representación formateada al buffer.
        println!("___MESSAGE ENDS___"); // Imprime un delimitador final.
        Result::Ok(()) // Devuelve un `Result::Ok` indicando que el formateo fue exitoso.
    }
}