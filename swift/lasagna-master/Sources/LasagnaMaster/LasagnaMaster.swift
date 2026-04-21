func remainingMinutesInOven(elapsedMinutes: Int, expectedMinutesInOven: Int = 40) -> Int {
  expectedMinutesInOven - elapsedMinutes
}

func preparationTimeInMinutes(layers: String...) -> Int {
  layers.count * 2
}

func quantities(layers: String...) -> (noodles: Int, sauce: Double) {
  var noodles = 0
  var litersOfSauce = 0.0
  for layer in layers {
    if layer == "noodles" {
      noodles += 3
    }
    if layer == "sauce" {
      litersOfSauce += 0.2
    }
  }
  return (noodles: noodles, sauce: litersOfSauce)
}

func toOz(_ ingredients: inout (noodles: Int, sauce: Double)) {
  ingredients.sauce *= 33.814
}

func redWine(layers: String...) -> Bool {
  // Spec wants us to create five nested functions...
  func mozzarella(_ layers: [String]) -> Int {
    var mozzarella = 0
    for layer in layers {
      if layer == "mozzarella" {
        mozzarella += 1
      }
    }
    return mozzarella
  }
  func ricotta(_ layers: [String]) -> Int {
    var ricotta = 0
    for layer in layers {
      if layer == "ricotta" {
        ricotta += 1
      }
    }
    return ricotta
  }
  func bechamel(_ layers: [String]) -> Int {
    var bechamel = 0
    for layer in layers {
      if layer == "béchamel" {
        bechamel += 1
      }
    }
    return bechamel
  }
  func sauce(_ layers: [String]) -> Int {
    var sauce = 0
    for layer in layers {
      if layer == "sauce" {
        sauce += 1
      }
    }
    return sauce
  }
  func meat(_ layers: [String]) -> Int {
    var meat = 0
    for layer in layers {
      if layer == "meat" {
        meat += 1
      }
    }
    return meat
  }
  let redLayers = meat(layers) + sauce(layers)
  let whiteLayers = mozzarella(layers) + ricotta(layers) + bechamel(layers)
  return redLayers >= whiteLayers
}
