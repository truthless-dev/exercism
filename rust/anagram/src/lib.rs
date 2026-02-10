use std::collections::{HashMap, HashSet};
use unicode_segmentation::UnicodeSegmentation;

/// Construct a mapping of graphemes to integers such that each
/// integer value is a count of how many times the grapheme appears
/// in the given string slice.
fn count_graphemes(s: &str) -> HashMap<String, u32> {
    s.graphemes(true)
        .fold(HashMap::new(), |mut accumulator, grapheme| {
            let count = accumulator.entry(grapheme.to_lowercase()).or_insert(0);
            *count += 1;
            accumulator
        })
    // `.fold()` returns the final value of `accumulator`, not another
    // iterator, so we can simply return its return value.
}

pub fn anagrams_for<'a>(word: &str, possible_anagrams: &[&'a str]) -> HashSet<&'a str> {
    let word_counts = count_graphemes(word);
    possible_anagrams
        .iter()
        .filter(|s| {
            if s.to_lowercase() == word.to_lowercase() {
                return false;
            }
            let possible_counts = count_graphemes(s);
            word_counts == possible_counts
        })
        .map(|s| *s)
        .collect()
}
