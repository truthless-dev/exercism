func getName(_ item: (name: String, amount: Int)) -> String {
  item.name
}

func createToy(name: String, amount: Int) -> (name: String, amount: Int) {
  (name: name, amount: amount)
}

func updateQuantity(_ items: [(name: String, amount: Int)], toy: String, amount: Int) -> [(
  name: String, amount: Int
)] {
  var items = items
  for i in 0..<items.count {
    if items[i].name == toy {
      items[i].amount = amount
    }
  }
  return items
}

func addCategory(_ items: [(name: String, amount: Int)], category: String) -> [(
  name: String, amount: Int, category: String
)] {
  var categorized: [(name: String, amount: Int, category: String)] = []
  for (name, amount) in items {
    let item = (name: name, amount: amount, category: category)
    categorized.append(item)
  }
  return categorized
}
