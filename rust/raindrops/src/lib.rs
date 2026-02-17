pub fn raindrops(n: u32) -> String {
    const PLING: &str = "Pling";
    const PLANG: &str = "Plang";
    const PLONG: &str = "Plong";

    let multiple_of_three = n.is_multiple_of(3);
    let multiple_of_five = n.is_multiple_of(5);
    let multiple_of_seven = n.is_multiple_of(7);

    if !(multiple_of_three || multiple_of_five || multiple_of_seven) {
        return n.to_string();
    }

    let mut sounds: Vec<&str> = Vec::with_capacity(3);
    if multiple_of_three {
        sounds.push(PLING);
    }
    if multiple_of_five {
        sounds.push(PLANG);
    }
    if multiple_of_seven {
        sounds.push(PLONG);
    }

    sounds.join("")
}
