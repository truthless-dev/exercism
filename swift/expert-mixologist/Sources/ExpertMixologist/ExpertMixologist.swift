func timeToPrepare(drinks: [String]) -> Double {
  let numberOfDrinks = drinks.count
  var totalTime = 0.0
  var i = 0
  while i < numberOfDrinks {
    let time =
      switch drinks[i] {
      case "beer": 0.5
      case "soda": 0.5
      case "water": 0.5
      case "shot": 1.0
      case "mixed drink": 1.5
      case "fancy drink": 2.5
      case "frozen drink": 3.0
      default: 0.0
      }
    totalTime += time
    i += 1
  }
  return totalTime
}

func makeWedges(needed: Int, limes: [String]) -> Int {
  var limesUsed = 0
  var slicesMade = 0
  let numberOfLimes = limes.count
  while slicesMade < needed && limesUsed < numberOfLimes {
    let slicesFromLime =
      switch limes[limesUsed] {
      case "small": 6
      case "medium": 8
      case "large": 10
      default: 0
      }
    slicesMade += slicesFromLime
    limesUsed += 1
  }
  return limesUsed
}

func finishShift(minutesLeft: Int, remainingOrders: [[String]]) -> [[String]] {
  let numberOfOrders = remainingOrders.count
  guard numberOfOrders > 0 else {
    return remainingOrders
  }
  var minutes = Double(minutesLeft)
  var orders = remainingOrders
  var i = 0
  repeat {
    let order = orders.removeFirst()
    let time = timeToPrepare(drinks: order)
    minutes -= time
    i += 1
  } while minutes > 0.0 && i < numberOfOrders
  return orders
}

func orderTracker(orders: [(drink: String, time: String)]) -> (
  beer: (first: String, last: String, total: Int)?, soda: (first: String, last: String, total: Int)?
) {
  var beer: (first: String, last: String, total: Int)? = nil
  var soda: (first: String, last: String, total: Int)? = nil
  let numberOfOrders = orders.count
  guard numberOfOrders > 0 else {
    return (beer: beer, soda: soda)
  }
  func update(drink: inout (first: String, last: String, total: Int)?, with time: String) {
    if drink == nil {
      drink = (first: time, last: time, total: 1)
    } else {
      drink?.last = time
      drink?.total += 1
    }
  }
  var i = 0
  repeat {
    let order = orders[i]
    if order.drink == "beer" {
      update(drink: &beer, with: order.time)
    }
    if order.drink == "soda" {
      update(drink: &soda, with: order.time)
    }
    i += 1
  } while i < numberOfOrders
  return (beer: beer, soda: soda)
}
