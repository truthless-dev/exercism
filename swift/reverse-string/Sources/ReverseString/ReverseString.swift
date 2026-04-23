func reverseString(_ input: String) -> String {
  input
    .reversed()
    .map { String($0) }
    .joined(separator: "")
}
