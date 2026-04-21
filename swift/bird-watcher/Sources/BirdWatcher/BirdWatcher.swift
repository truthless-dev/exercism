func totalBirdCount(_ birdsPerDay: [Int]) -> Int {
  // Specification wants us to calculate this with a for-loop.
  var total = 0
  for birds in birdsPerDay {
    total += birds
  }
  return total
}

func birdsInWeek(_ birdsPerDay: [Int], weekNumber: Int) -> Int {
  // Each week contains 7 values, according to the spec.
  let daysPerWeek = 7
  let start = (weekNumber - 1) * daysPerWeek
  let end = start + daysPerWeek
  let week = Array(birdsPerDay[start..<end])
  return totalBirdCount(week)
}

func fixBirdCountLog(_ birdsPerDay: [Int]) -> [Int] {
  var birdsPerDay = birdsPerDay
  for day in stride(from: 0, to: birdsPerDay.count, by: 2) {
    birdsPerDay[day] += 1
  }
  return birdsPerDay
}
