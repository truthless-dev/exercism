typealias ChangeClosure = @Sendable ((String, String, String)) -> (String, String, String)

let flip: ChangeClosure = { ($0.1, $0.0, $0.2) }
let rotate: ChangeClosure = { ($0.1, $0.2, $0.0) }

func makeShuffle(
  flipper: @escaping ((String, String, String)) -> (String, String, String),
  rotator: @escaping ((String, String, String)) -> (String, String, String)
) -> ([UInt8], (String, String, String)) -> (String, String, String) {
  {
    var wires = $1
    for bit in $0.reversed() {
      switch bit {
      case 0: wires = flipper(wires)
      case 1: wires = rotator(wires)
      default: break  // Bits are only 0 or 1.
      }
    }
    return wires
  }
}
