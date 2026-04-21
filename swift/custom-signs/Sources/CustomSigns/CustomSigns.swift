let birthday = "Birthday"
let valentine = "Valentine's Day"
let anniversary = "Anniversary"

let space: Character = " "
let exclamation: Character = "!"

func buildSign(for occasion: String, name: String) -> String {
  // Specification indicates that the string should be built via concatenation.
  var sign = "Happy"
  sign += String(space)
  sign += occasion
  sign += String(space)
  sign += name
  sign += String(exclamation)
  return sign
}

func graduationFor(name: String, year: Int) -> String {
  // Specification indicates that the string should be built via interpolation.
  "Congratulations \(name)!\nClass of \(year)"
}

func costOf(sign: String) -> Int {
  20 + (2 * sign.count)
}
