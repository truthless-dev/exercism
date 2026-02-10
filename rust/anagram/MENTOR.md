# Mentor Discussion

## Me

While correct, the solution is not, I suspect, idiomatic Rust, par-
ticularly the body of the `count_graphemes` function. Both the call to
`(**s).to_lowercase()` and the use of the for loop feel a bit too
messy. Is there a cleaner, more idiomatic way to build this HashMap?
Thank you in advance for your help!

## Mentor

Hello <me>,

Good to meet you here. That's a nice solution! I have a couple of
suggestions to address your points regarding idiomatic Rust, maybe
you'll find them helpful.

First, in line 18 you don't need the dereferencing, `.` reaches through
references. This

```rust
        ...
        .filter(|s| {
            if s.to_lowercase() == word.to_lowercase() {
            ...
            ```

works fine. Then, instead of the for-loop in `count_graphemes` you
could use the iterator method `.fold`, like

```rust
fn count_graphemes(s: &str) -> HashMap<String, u32> {
    s.graphemes(true)
        .fold(HashMap::new(), |mut counts, g| {
            *counts.entry(g.to_lowercase()).or_insert(0) += 1;
            counts
        })
}
```

which would be a bit more idiomatic. And for line 24 you could use
`.copied()`, which is the same (see the comment in the example in the docs).

If you're interested, I have also a couple of performance related
observations. First, you could add a cheap length comparison at the
start the `.filter` body which might save some lowercasing and calls to
`count_graphemes`:

```rust
        ...
        .filter(|s| {
            if s.len() != word.len() || s.to_lowercase() == word.to_lowercase() {
                return false;
            }
            ...
```

Then, you're lowercasing a lot, which means a lot of heap allocations.
You could reduce that significantly by pulling the lowercasing out of
`count_graphemes`, saving a lowercased version of word upfront, split
the length comparison from the lowercasing, and to store a lowercased
version of s to potentially use it for the `count_graphemes` call. Like:

```rust
fn count_graphemes<'a>(s: &'a str) -> HashMap<&'a str, u32> {
    s.graphemes(true)
        .fold(HashMap::new(), |mut counts, g| {
            *counts.entry(g).or_insert(0) += 1;
            counts
        })
}

pub fn anagrams_for<'a>(word: &str, possible_anagrams: &[&'a str]) -> HashSet<&'a str> {
    let word_lower = word.to_lowercase();
    let word_counts = count_graphemes(&word_lower);
    possible_anagrams
        .iter()
        .filter(|s| {
            if s.len() != word.len() {
                return false
            }
            let s_lower = s.to_lowercase();
            if s_lower == word_lower {
                return false
            }
            word_counts == count_graphemes(&s_lower)
        })
        .copied()
        .collect()
}
```

Hope that's helpful. Let me know if not or if I've missed you question!

Cheers, <Mentor>

### Summary

* No need to dereference `s` to lowercase it.
* Use `.fold()` instead of the for-loop.
* Check out `.copied()`.
* Compare lengths of `word` and `s` first.
* Cut down on lowercasing (allocations) by moving `to_lowercase()` calls.
