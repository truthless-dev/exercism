use convert_case::ccase;

fn plural_bottles(number_of_bottles: u32) -> String {
    if number_of_bottles == 1 {
        String::from("bottle")
    } else {
        String::from("bottles")
    }
}

/// Generate a verse of the song given a starting number of bottles.
/// The `number_as_word` param should be a sequence that provides the
/// word form of each of its indices (e.g., "one" at index 1, "two"
/// at index 2).
///
/// # Panics
///
/// If `number_of_bottles` is greater than the length of
/// `number_as_word`.
fn make_verse(number_of_bottles: u32, number_as_word: &Vec<&str>) -> String {
    let index = number_of_bottles as usize;
    let start_count = ccase!(pascal, number_as_word.get(index).unwrap());
    let start_bottles = plural_bottles(number_of_bottles);
    let next_count = number_as_word.get(index - 1).unwrap();
    let next_bottles = plural_bottles(number_of_bottles - 1);

    format!(
        "\
{start_count} green {start_bottles} hanging on the wall,\n\
{start_count} green {start_bottles} hanging on the wall,\n\
And if one green bottle should accidentally fall,\n\
There'll be {next_count} green {next_bottles} hanging on the wall.\n\
\n\
"
    )
}

pub fn recite(start_bottles: u32, take_down: u32) -> String {
    if start_bottles == 0 {
        return String::from("No song to sing.");
    }
    let number_as_word = vec![
        "no", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten",
    ];
    if start_bottles > number_as_word.len() as u32 {
        return String::from("Too many bottles.");
    }
    if take_down > start_bottles {
        return String::from("Cannot take more bottles than you start with.");
    }

    let mut song = String::new();
    for i in 0..take_down {
        let verse = make_verse(start_bottles - i, &number_as_word);
        song.push_str(&verse);
    }
    song
}
