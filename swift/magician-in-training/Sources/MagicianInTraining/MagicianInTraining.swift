func getCard(at index: Int, from stack: [Int]) -> Int {
  // This might crash, but the specification does not indicate how errors
  // should be handled.
  stack[index]
}

func setCard(at index: Int, in stack: [Int], to newCard: Int) -> [Int] {
  if index < 0 || index >= stack.count {
    return stack
  }
  var stack = stack
  stack[index] = newCard
  return stack
}

func insert(_ newCard: Int, atTopOf stack: [Int]) -> [Int] {
  var stack = stack
  stack.append(newCard)
  return stack
}

func removeCard(at index: Int, from stack: [Int]) -> [Int] {
  let stackHeight = stack.count
  if stackHeight == 0 || index >= stackHeight {
    return stack
  }
  var stack = stack
  if index == stackHeight - 1 {
    stack.removeLast()
  } else {
    stack.remove(at: index)
  }
  return stack
}

func insert(_ newCard: Int, at index: Int, from stack: [Int]) -> [Int] {
  if index < 0 || index > stack.count {
    return stack
  }
  var stack = stack
  stack.insert(newCard, at: index)
  return stack
}

func checkSizeOfStack(_ stack: [Int], _ size: Int) -> Bool {
  size == stack.count
}
