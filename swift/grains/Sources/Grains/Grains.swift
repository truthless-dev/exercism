enum GrainsError: Error {
  case inputTooLow
  case inputTooHigh
}

struct Grains {
  static var total: UInt64 {
    (1...64).reduce(0) {
      let nextSquare = try! Self.square($1)
      return $0 + nextSquare
    }
  }

  static func square(_ num: Int) throws(GrainsError) -> UInt64 {
    guard num > 0 else {
      throw .inputTooLow
    }
    guard num <= 64 else {
      throw .inputTooHigh
    }
    return 1 << (num - 1)
  }
}
