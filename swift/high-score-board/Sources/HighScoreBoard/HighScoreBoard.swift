func newScoreBoard() -> [String: Int] {
  [:]
}

func addPlayer(_ scores: inout [String: Int], _ name: String, _ score: Int = 0) {
  scores[name] = score
}

func removePlayer(_ scores: inout [String: Int], _ name: String) {
  scores[name] = nil
}

func resetScore(_ scores: inout [String: Int], _ name: String) {
  if scores.keys.contains(name) {
    scores[name] = 0
  }
}

func updateScore(_ scores: inout [String: Int], _ name: String, _ delta: Int) {
  if let score = scores[name] {
    scores[name] = score + delta
  }
}

func orderByPlayers(_ scores: [String: Int]) -> [(String, Int)] {
  scores.sorted { $0.0 < $1.0 }
}

func orderByScores(_ scores: [String: Int]) -> [(String, Int)] {
  scores.sorted { $0.1 > $1.1 }
}
