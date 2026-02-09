use std::collections::{HashMap, HashSet};
use unicode_segmentation::UnicodeSegmentation;

fn count_graphemes(s: &str) -> HashMap<String, u32> {
    let mut counts = HashMap::new();
    for g in s.graphemes(true) {
        let count = counts.entry(g.to_lowercase()).or_insert(0u32);
        *count += 1;
    }
    counts
}

pub fn anagrams_for<'a>(word: &str, possible_anagrams: &[&'a str]) -> HashSet<&'a str> {
    let word_counts = count_graphemes(word);
    possible_anagrams
        .iter()
        .filter(|s| {
            if (**s).to_lowercase() == word.to_lowercase() {
                return false;
            }
            let possible_counts = count_graphemes(s);
            word_counts == possible_counts
        })
        .map(|s| *s)
        .collect()
}
