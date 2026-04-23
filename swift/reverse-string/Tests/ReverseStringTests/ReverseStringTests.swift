import Foundation
import Testing

@testable import ReverseString

let RUNALL = Bool(ProcessInfo.processInfo.environment["RUNALL", default: "false"]) ?? false

@Suite struct ReverseStringTests {

  @Test("an empty string")
  func testAnEmptyString() {
    #expect(reverseString("") == "")
  }

  @Test("a word")
  func testAWord() {
    #expect(reverseString("robot") == "tobor")
  }

  @Test("a capitalized word")
  func testACapitalizedWord() {
    #expect(reverseString("Ramen") == "nemaR")
  }

  @Test("a sentence with punctuation")
  func testASentenceWithPunctuation() {
    #expect(reverseString("I'm hungry!") == "!yrgnuh m'I")
  }

  @Test("a palindrome")
  func testAPalindrome() {
    #expect(reverseString("racecar") == "racecar")
  }

  @Test("an even-sized word")
  func testAnEvenSizedWord() {
    #expect(reverseString("drawer") == "reward")
  }
}
