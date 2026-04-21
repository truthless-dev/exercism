func dailyRateFrom(hourlyRate: Int) -> Double {
  Double(hourlyRate) * 8.0
}

func monthlyRateFrom(hourlyRate: Int, withDiscount discount: Double) -> Double {
  let flatRate = dailyRateFrom(hourlyRate: hourlyRate) * 22.0
  let discountAsPercentage = discount * 0.01
  let discountedAmount = flatRate * discountAsPercentage
  return flatRate - discountedAmount
}

func workdaysIn(budget: Double, hourlyRate: Int, withDiscount discount: Double) -> Double {
  let dailyRate = dailyRateFrom(hourlyRate: hourlyRate)
  let discountAsPercentage = discount * 0.01
  let dailyDiscountedAmount = dailyRate * discountAsPercentage
  let discountedDailyRate = dailyRate - dailyDiscountedAmount
  let daysWithinBudget = budget / discountedDailyRate
  return daysWithinBudget.rounded(.down)
}
