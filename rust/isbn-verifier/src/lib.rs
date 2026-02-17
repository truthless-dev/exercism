/// Determines whether the supplied string is a valid ISBN number
pub fn is_valid_isbn(isbn: &str) -> bool {
    let mut numbers: Vec<u32> = Vec::new();

    for c in isbn.chars() {
        if c == '-' {
            continue;
        }
        if c == 'X' {
            numbers.push(10);
        } else if let Some(digit) = c.to_digit(10) {
            numbers.push(digit);
        } else {
            // Invalid character.
            return false;
        }
    }

    if numbers.len() != 10 {
        return false;
    }

    let mut total: u32 = 0;
    for (i, &n) in numbers.iter().enumerate() {
        if i < 9 && n == 10 {
            // 10 allowed only in the last position.
            return false;
        }
        total += n * (i as u32 + 1)
    }

    total % 11 == 0
}
