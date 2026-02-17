pub fn abbreviate(phrase: &str) -> String {
    let mut acronym = String::new();

    let mut in_word = false;
    let mut is_camel_case = false;

    for c in phrase.chars() {
        if in_word {
            if !c.is_alphabetic() && c != '\'' {
                // Reached word boundary (apostrophe does not break a word).
                in_word = false;
                is_camel_case = false;
            } else if c.is_lowercase() && !is_camel_case {
                is_camel_case = true;
            } else if c.is_uppercase() && is_camel_case {
                acronym.push(c);
            }
        } else {
            if c.is_alphabetic() {
                in_word = true;
                if c.is_lowercase() {
                    is_camel_case = true;
                    c.to_uppercase().for_each(|c| acronym.push(c));
                } else if c.is_uppercase() {
                    acronym.push(c);
                }
            }
        }
    }

    acronym
}
