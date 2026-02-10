use std::convert::TryFrom;

pub fn is_armstrong_number(num: u32) -> bool {
    // Construct a list of `num`'s digits.
    let mut copy = num;
    let mut digits: Vec<u32> = Vec::new();
    while copy != 0 {
        digits.push(copy % 10);
        copy = copy / 10;
    }

    let digit_count = u32::try_from(digits.len()).expect("`num` too large.");
    let total = digits
        .iter()
        .fold(0, |total, digit| total + digit.pow(digit_count));

    total == num
}
