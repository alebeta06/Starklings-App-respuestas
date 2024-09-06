fn bigger(a: usize, b: usize) -> usize {
    // Usa una expresión condicional para devolver el mayor valor
    if a > b {
        a
    } else {
        b
    }
}

#[cfg(test)]
mod tests {
    use super::bigger;

    #[test]
    fn ten_is_bigger_than_eight() {
        assert(10 == bigger(10, 8), '10 bigger than 8');
    }

    #[test]
    fn fortytwo_is_bigger_than_thirtytwo() {
        assert(42 == bigger(32, 42), '42 bigger than 32');
    }
}