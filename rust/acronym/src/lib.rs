/// Determine whether a string contains only uppercase chars.
fn is_uppercase(word: &str) -> bool {
    word.chars().all(|c| c.is_uppercase())
}

/// Split a string by spaces and hyphens.
fn get_words(s: &str) -> Vec<&str> {
    s.split(['-', ' '].as_slice()).collect()
}

pub fn abbreviate(phrase: &str) -> String {
    let mut acronym = String::new();
    for word in get_words(phrase) {
        let mut iter_chars = word.chars();

        // Find the word's first alphabetic character.
        while let Some(c) = iter_chars.next() {
            if c.is_alphabetic() {
                c.to_uppercase().for_each(|c| acronym.push(c));
                break;
            }
        }

        if is_uppercase(word) {
            continue;
        }

        // If the word is camel-cased, add each uppercase char.
        iter_chars
            .filter(|c| c.is_uppercase())
            .for_each(|c| acronym.push(c));
    }

    acronym
}
