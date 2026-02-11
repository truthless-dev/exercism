//! Verify codes using the Luhn algorithm.
//!
//! The algorithm works as follows:
//!
//! 1. Strip all whitespace from the input.
//! 1. If the stripped input contains 0 or 1 chars, it's invalid.
//! 1. If the input contains non-digits, it's invalid.
//! 1. For each digit from right to left, if the digit's index is even,
//! keep it as-is. If it's odd, double the digit and, if the result is
//! greater than 9, subtract 9 from it.
//! 1. Sum the resulting digits.
//! 1. If the sum is a multiple of 10, the code is valid. Otherwise,
//! it is not.

/// Handle a digit within a code.
///
/// When `i` is odd, return `digit` unchanged. Otherwise, return
/// `digit` doubled and, if needed, reduced by 9.
fn convert(index: usize, digit: u32) -> u32 {
    if index % 2 == 0 {
        return digit;
    }
    let doubled = digit * 2;
    if doubled > 9 { doubled - 9 } else { doubled }
}

/// Check a Luhn checksum.
pub fn is_valid(code: &str) -> bool {
    let stripped_code = code.replace(" ", "");
    if stripped_code.len() <= 1 {
        return false;
    }

    let mut digits: Vec<u32> = Vec::new();
    for (i, c) in stripped_code.chars().rev().enumerate() {
        if let Some(digit) = c.to_digit(10) {
            digits.push(convert(i, digit));
        } else {
            // Only digits allowed.
            return false;
        }
    }

    digits.iter().sum::<u32>() % 10 == 0
}
