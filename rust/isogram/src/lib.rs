use std::collections::HashMap;

pub fn check(candidate: &str) -> bool {
    candidate
        .to_lowercase()
        .chars()
        .filter(|c| c.is_alphabetic())
        .fold(HashMap::new(), |mut acc, c| {
            *acc.entry(c).or_insert(0) += 1;
            acc
        })
        .values()
        .all(|&count| count == 1)
}
