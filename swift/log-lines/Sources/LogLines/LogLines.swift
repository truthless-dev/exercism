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
    var number: Int
    switch self {
    case .trace:
      number = 0
    case .debug:
      number = 1
    case .info:
      number = 4
    case .warning:
      number = 5
    case .error:
      number = 6
    case .fatal:
      number = 7
    default:
      number = 42
    }
    return "\(number):\(message)"
  }
}
