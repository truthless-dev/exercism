func modifier(_ score: Int) -> Int {
  let mod = (Double(score) - 10.0) / 2.0
  return Int(mod.rounded(.down))
}

func ability() -> Int {
  (0..<4)
    .reduce(into: [Int]()) { rolls, _ in
      let roll = Int.random(in: (1...6))
      rolls.append(roll)
    }
    .sorted(by: >)[0..<3]
    .reduce(0, +)
}

struct DndCharacter {
  var strength: Int
  var dexterity: Int
  var constitution: Int
  var intelligence: Int
  var wisdom: Int
  var charisma: Int
  var hitpoints: Int

  init() {
    strength = ability()
    dexterity = ability()
    constitution = ability()
    intelligence = ability()
    wisdom = ability()
    charisma = ability()
    hitpoints = 10 + modifier(constitution)
  }
}
