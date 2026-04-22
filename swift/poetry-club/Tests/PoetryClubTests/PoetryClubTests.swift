import Testing
import Foundation

@testable import PoetryClub

let RUNALL = Bool(ProcessInfo.processInfo.environment["RUNALL", default: "false"]) ?? false

@Suite struct PoetryClubTests {
  @Test("splitOnNewlines")
  func testSplitOnNewlines() {
    #expect(
      splitOnNewlines("Winken.\nBlinken\n\nAnd Nod.") ==
      ["Winken.", "Blinken", "", "And Nod."]
    )
  }

  @Test("splitOnNewlines with only one Line")
  func testSplitNoNewlines() {
    #expect(
      splitOnNewlines("Hello.") == ["Hello."]
    )
  }

  @Test("splitOnNewlines with empty string")
  func testSplitEmptyString() {
    #expect(
      splitOnNewlines("") == [""]
    )
  }

  @Test("frontDoorPassword")
  func testFrontDoorPassword() {
    #expect(
      frontDoorPassword("Winken.\nBlinken\nAnd Nod.") == "WBA"
    )
  }

  @Test("frontDoorPassword with another string")
  func testFrontDoorPasswordAnotherString() {
    #expect(
      frontDoorPassword("Hello.\nWorld") == "HW"
    )
  }

  @Test("frontDoorPassword with only one Line")
  func testFrontDoorPasswordNoNewlines() {
    #expect(
      frontDoorPassword("Hello.") == "H"
    )
  }

  @Test("frontDoorPassword with empty string")
  func testFrontDoorPasswordEmptyString() {
    #expect(
      frontDoorPassword("") == "_"
    )
  }

  @Test("backDoorPassword")
  func testBackDoorPassword() {
    #expect(
      backDoorPassword("Allow\nForumla\nIn\nAcid")
        == "wand, please"
    )
  }

  @Test("backDoorPassword trailing whitespace")
  func testBackDoorPasswordAnotherString() {
    #expect(
      backDoorPassword("Hello   \nWorld         ") == "od, please"
    )
  }

  @Test("backDoorPassword with only one Line")
  func testBackDoorPasswordNoNewlines() {
    #expect(
      backDoorPassword("Hello        ") == "o, please"
    )
  }

  @Test("backDoorPassword with only last line having trailing space")
  func testBackDoorPasswordLastLineTrailingSpace() {
    #expect(
      backDoorPassword("Hello\nWorld        ") == "od, please"
    )
  }

  @Test("secretRoomPassword")
  func testSecretRoomPassword() {
    #expect(
      secretRoomPassword("Winken.\nBlinken\nWhisper") == "WLI!"
    )
  }

  @Test("secretRoomPassword with another string")
  func testSecretRoomPasswordAnotherString() {
    #expect(
      secretRoomPassword("Hello\nWorld\nHappy\nHere") == "HOPE!"
    )
  }

  @Test("secretRoomPassword with only one Line")
  func testsecretRoomPasswordWithOnlyOneLine() {
    #expect(
      secretRoomPassword("Hello") == "H!"
    )
  }
}
