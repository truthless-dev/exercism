import Foundation

func splitOnNewlines(_ poem: String) -> [String] {
  poem.components(separatedBy: "\n")
}

func frontDoorPassword(_ phrase: String) -> String {
  let firstLetters = splitOnNewlines(phrase).map { String($0.first ?? "_") }
  return firstLetters.joined(separator: "").uppercased()
}

func backDoorPassword(_ phrase: String) -> String {
  let lastLetters = splitOnNewlines(phrase).map {
    let trimmedLine = $0.trimmingCharacters(in: .whitespacesAndNewlines)
    return String(trimmedLine.last ?? "_")
  }
  let word = lastLetters.joined(separator: "").lowercased()
  return "\(word), please"
}

func secretRoomPassword(_ phrase: String) -> String {
  let lines = splitOnNewlines(phrase)
  var diagonalLetters: [String] = []
  for i in 0..<lines.count {
    let trimmedLine = lines[i].trimmingCharacters(in: .whitespacesAndNewlines)
    let index = trimmedLine.index(
      trimmedLine.startIndex, offsetBy: i, limitedBy: trimmedLine.endIndex)
    if let index = index {
      let char = trimmedLine[index]
      diagonalLetters.append(String(char))
    }
  }
  let word = diagonalLetters.joined(separator: "").uppercased()
  return "\(word)!"
}
