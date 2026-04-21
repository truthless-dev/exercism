func canIBuy(vehicle: String, price: Double, monthlyBudget: Double) -> String {
  let monthsInFiveYears = 12 * 5
  let monthlyPayment = price / (Double(monthsInFiveYears))
  if monthlyPayment <= monthlyBudget {
    return "Yes! I'm getting a \(vehicle)"
  }
  let allowableOverBudget = monthlyBudget * 1.1
  if monthlyPayment <= allowableOverBudget {
    return "I'll have to be frugal if I want a \(vehicle)"
  }
  return "Darn! No \(vehicle) for me"
}

func licenseType(numberOfWheels wheels: Int) -> String {
  if wheels == 2 || wheels == 3 {
    return "You will need a motorcycle license for your vehicle"
  }
  if wheels == 4 || wheels == 6 {
    return "You will need an automobile license for your vehicle"
  }
  if wheels == 18 {
    return "You will need a commercial trucking license for your vehicle"
  }
  return "We do not issue licenses for those types of vehicles"
}

func calculateResellPrice(originalPrice: Int, yearsOld: Int) -> Int {
  let original = Double(originalPrice)
  if yearsOld < 3 {
    return Int(original * 0.8)
  }
  if yearsOld >= 10 {
    return Int(original * 0.5)
  }
  return Int(original * 0.7)
}
