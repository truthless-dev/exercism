enum LogLevel: String {
  case trace = "TRC"
  case debug = "DBG"
  case info = "INF"
  case warning = "WRN"
  case error = "ERR"
  case fatal = "FTL"
  case unknown

  init(_ line: String) {
    let start = line.index(line.startIndex, offsetBy: 1)
    let end = line.index(line.startIndex, offsetBy: 3)
    let sub = line[start...end]
    let value = String(sub)
    self = Self.init(rawValue: value) ?? .unknown
  }

  func shortFormat(message: String) -> String {
    let number =
      switch self {
      case .trace: 0
      case .debug: 1
      case .info: 4
      case .warning: 5
      case .error: 6
      case .fatal: 7
      default: 42
      }
    return "\(number):\(message)"
  }
}
