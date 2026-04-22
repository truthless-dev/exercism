import Foundation

func sliceSize(diameter: Double?, slices: Int?) -> Double? {
  guard let diameter = diameter, let slices = slices else {
    return nil
  }
  if diameter < 0.0 || slices < 1 {
    return nil
  }
  let radius = diameter / 2.0
  let totalArea = Double.pi * pow(radius, 2.0)
  return totalArea / Double(slices)
}

func biggestSlice(
  diameterA: String, slicesA: String,
  diameterB: String, slicesB: String
) -> String {
  let areaA = sliceSize(diameter: Double(diameterA), slices: Int(slicesA))
  let areaB = sliceSize(diameter: Double(diameterB), slices: Int(slicesB))
  switch (areaA, areaB) {
  case let (a?, b?):
    return if a > b {
      "Slice A is bigger"
    } else if a < b {
      "Slice B is bigger"
    } else {
      "Neither slice is bigger"
    }
  case let (a?, nil):
    return "Slice A is bigger"
  case let (nil, b?):
    return "Slice B is bigger"
  default:
    return "Neither slice is bigger"
  }
}
