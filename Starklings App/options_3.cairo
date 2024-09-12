#[derive(Drop)]
struct Student {
    name: felt252,
    courses: Array<Option<felt252>>,
}

fn display_grades(student: @Student, index: usize) {

    // Si el índice es 0, imprime el nombre del estudiante junto con "index 0".
    if index == 0 {
        println!("{} index 0", *student.name);
    }
    
    // Verifica si el índice actual es mayor o igual a la cantidad de cursos del estudiante,
    // en cuyo caso, detiene la recursión.
    if index >= student.courses.len() {
        return ();
    }

    // Obtiene el curso en la posición actual.
    let course = *student.courses.at(index);

    // Verifica si el curso tiene una nota (Some) y la imprime, de lo contrario, imprime "No grade".
    if course.is_some() {
        println!("grade is {}", course.unwrap());
    } else if course.is_none() {
        println!("No grade");
    }

    // Llama recursivamente para imprimir la siguiente nota.
    display_grades(student, index + 1);
}

#[test]
#[available_gas(20000000)]
fn test_all_defined() {
    // Prueba con todos los cursos definidos.
    let courses = array![
        Option::Some('A'),
        Option::Some('B'),
        Option::Some('C'),
        Option::Some('A'),
    ];
    let mut student = Student { name: 'Alice', courses: courses };
    display_grades(@student, 0);
}

#[test]
#[available_gas(20000000)]
fn test_some_empty() {
    // Prueba con algunos cursos sin calificación (None).
    let courses = array![
        Option::Some('A'),
        Option::None,
        Option::Some('B'),
        Option::Some('C'),
        Option::None,
    ];
    let mut student = Student { name: 'Bob', courses: courses };
    display_grades(@student, 0);
}