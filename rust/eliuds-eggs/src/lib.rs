pub fn egg_count(display_value: u32) -> usize {
    let value = display_value as usize;
    let mut eggs: usize = 0;
    let mut bit: usize = 1;
    while bit != 0 {
        eggs += if value & bit != 0 { 1 } else { 0 };
        bit <<= 1;
    }
    eggs
}
