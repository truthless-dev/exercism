use std::collections::{HashMap, HashSet};
use unicode_segmentation::UnicodeSegmentation;

/// Construct a mapping of graphemes to integers such that each
/// integer value is a count of how many times the grapheme appears
/// in the given string slice.
fn count_graphemes(s: &str) -> HashMap<&str, u32> {
    s.graphemes(true)
        .fold(HashMap::new(), |mut accumulator, grapheme| {
            let count = accumulator.entry(grapheme).or_insert(0);
            *count += 1;
            accumulator
        })
    // `.fold()` returns the final value of `accumulator`, not another
    // iterator, so we can simply return its return value.
}

pub fn anagrams_for<'a>(word: &str, possible_anagrams: &[&'a str]) -> HashSet<&'a str> {
    let word_lower = word.to_lowercase();
    let word_counts = count_graphemes(&word_lower);
    possible_anagrams
        .iter()
        .filter(|s| {
            if s.len() != word_lower.len() {
                // If the strings are of different lengths, they cannot
                // be anagrams.
                // We check this before lowercasing `s` in order to
                // avoid unnecessary memory allocations.
                return false;
            }

            let s_lower = s.to_lowercase();
            if s_lower == word_lower {
                // A word is not an anagram of itself.
                return false;
            }

            let s_counts = count_graphemes(&s_lower);
            s_counts == word_counts
        })
        .copied()
        .collect()
}
