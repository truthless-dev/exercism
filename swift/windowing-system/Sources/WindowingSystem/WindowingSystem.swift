struct Size {
  var width = 80
  var height = 60

  mutating func resize(newWidth: Int, newHeight: Int) {
    width = newWidth
    height = newHeight
  }
}

struct Position {
  var x = 0
  var y = 0

  mutating func moveTo(newX: Int, newY: Int) {
    x = newX
    y = newY
  }
}

class Window {
  var title = "New Window"
  let screenSize = Size(width: 800, height: 600)
  var size = Size()
  var position = Position()
  var contents: String?

  init() {
  }

  init(
    title: String, contents: String?, size: Size = Size(),
    position: Position = Position()
  ) {
    self.title = title
    self.contents = contents
    self.size = size
    self.position = position
  }

  func resize(to size: Size) {
    func clamp(_ dimension: Int, within screenSize: Int, givenPosition position: Int) -> Int {
      if dimension < 1 {
        return 1
      }
      if dimension + position > screenSize {
        return screenSize - position
      }
      return dimension
    }
    self.size.width = clamp(
      size.width, within: self.screenSize.width, givenPosition: self.position.x)
    self.size.height = clamp(
      size.height, within: self.screenSize.height, givenPosition: self.position.y)
  }

  func move(to position: Position) {
    func clamp(_ position: Int, within screenSize: Int, givenDimension dimension: Int) -> Int {
      if position < 0 {
        return 0
      }
      if position + dimension > screenSize {
        return screenSize - dimension
      }
      return position
    }
    self.position.x = clamp(
      position.x, within: self.screenSize.width, givenDimension: self.size.width)
    self.position.y = clamp(
      position.y, within: self.screenSize.height, givenDimension: self.size.height)
  }

  func update(title: String) {
    self.title = title
  }

  func update(text: String?) {
    contents = text
  }

  func display() -> String {
    """
    \(title)
    Position: (\(position.x), \(position.y)), Size: (\(size.width) x \(size.height))
    \(contents ?? "[This window intentionally left blank]")\n
    """
  }
}
