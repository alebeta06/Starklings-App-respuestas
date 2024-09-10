use core::fmt::{Display, Formatter, Error};

// Definición de un enumerado `Message` que contiene varios tipos de mensajes.
// Este enumerado nos permite definir valores con nombres que representan diferentes tipos de mensajes.
#[derive(Drop)]
enum Message {
    Quit,        // Representa una acción de "Salir"
    Echo,        // Representa una acción de "Repetir"
    Move,        // Representa una acción de "Mover"
    ChangeColor, // Representa una acción de "Cambiar color"
}

// La función `main` imprime cada tipo de mensaje utilizando la implementación de `Display`.
// No hacemos ningún cambio en esta función, ya que el código de impresión funciona con los valores del enumerado.
fn main() {
    println!("{}", Message::Quit);        // Imprime el valor `Quit`
    println!("{}", Message::Echo);        // Imprime el valor `Echo`
    println!("{}", Message::Move);        // Imprime el valor `Move`
    println!("{}", Message::ChangeColor); // Imprime el valor `ChangeColor`
}

// Implementación del trait `Display` para el tipo `Message`.
// Esto nos permite convertir los valores de `Message` en cadenas de texto para ser impresas.
impl MessageDisplay of Display<Message> {
    // La función `fmt` se utiliza para dar formato a los valores de `Message` y convertirlos en cadenas.
    fn fmt(self: @Message, ref f: Formatter) -> Result<(), Error> {
        // Creamos una variable `str` que contendrá la representación en texto del valor `Message`.
        let str: ByteArray = match self {
            Message::Quit => format!("Quit"),          // Si el valor es `Quit`, la cadena será "Quit"
            Message::Echo => format!("Echo"),          // Si el valor es `Echo`, la cadena será "Echo"
            Message::Move => format!("Move"),          // Si el valor es `Move`, la cadena será "Move"
            Message::ChangeColor => format!("ChangeColor") // Si el valor es `ChangeColor`, la cadena será "ChangeColor"
        };

        // Utilizamos el buffer de `Formatter` para agregar la cadena formateada.
        // Este buffer es donde se almacena temporalmente la salida de la cadena antes de imprimirse.
        f.buffer.append(@str);

        // Devolvemos un resultado exitoso después de agregar la cadena al buffer.
        Result::Ok(())
    }
}