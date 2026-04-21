let ranks = 1...8
let files = "A"..."H"

func isValidSquare(rank: Int, file: String) -> Bool {
  ranks.contains(rank) && files.contains(file)
}

func getRow(_ board: [String], rank: Int) -> [String] {
  // Hard-coding 8 instead of `files.count` here because `.count` does
  // not work on String ranges. In a real-world context, we'd probably
  // want to calculate the width dynamically.
  let rowWidth = 8
  let start = (rank - 1) * rowWidth
  let end = start + rowWidth
  return Array(board[start..<end])
}
