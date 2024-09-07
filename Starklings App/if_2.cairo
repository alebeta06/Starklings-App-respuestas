fn foo_if_fizz(fizzish: felt252) -> felt252 {
    // Usamos bloques if, else if y else para las diferentes condiciones.
    if fizzish == 'fizz' {
        'foo'
    } else if fizzish == 'fuzz' {
        'bar'
    } else {
        'baz'
    }
}

// No test changes needed!
#[cfg(test)]
mod tests {
    use super::foo_if_fizz;

    #[test]
    fn foo_for_fizz() {
        assert(foo_if_fizz('fizz') == 'foo', 'fizz returns foo')
    }

    #[test]
    fn bar_for_fuzz() {
        assert(foo_if_fizz('fuzz') == 'bar', 'fuzz returns bar');
    }

    #[test]
    fn default_to_baz() {
        assert(foo_if_fizz('literally anything') == 'baz', 'anything else returns baz');
    }
}
