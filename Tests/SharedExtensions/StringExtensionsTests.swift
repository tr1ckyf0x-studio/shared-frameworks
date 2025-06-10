//
//  StringExtensionsTests.swift
//  shared-frameworks
//
//  Created by Vladislav Lisianskii on 10. 6. 2025..
//

import Testing
import Foundation
@testable import SharedExtensions

@Suite
struct StringExtensionsTests {
    // MARK: - filter(byAllowedCharacters:)
    @Test
    func testFilterLettersOnly() {
        let input = "Hello, World!123"
        let allowed = CharacterSet.letters.union(.whitespaces)
        let result = input.filter(byAllowedCharacters: allowed)
        #expect(result == "Hello World")
    }

    @Test
    func testFilterDigitsOnly() {
        let input = "A1B2C3"
        let allowed = CharacterSet.decimalDigits
        let result = input.filter(byAllowedCharacters: allowed)
        #expect(result == "123")
    }

    @Test
    func testFilterEmptyResult() {
        let input = "!@#$%^"
        let allowed = CharacterSet.alphanumerics
        let result = input.filter(byAllowedCharacters: allowed)
        #expect(result == "")
    }

    // MARK: - replacingSubrange(_:with:)
    @Test
    func testReplacingStartOfString() {
        let input = "HelloWorld"
        let range = input.startIndex..<input.index(input.startIndex, offsetBy: 5)
        let result = input.replacingSubrange(range, with: "Hi")
        #expect(result == "HiWorld")
    }

    @Test
    func testReplacingMiddleOfString() {
        let input = "SwiftExtensions"
        let start = input.index(input.startIndex, offsetBy: 5)
        let end = input.endIndex
        let result = input.replacingSubrange(start..<end, with: "Lib")
        #expect(result == "SwiftLib")
    }

    @Test
    func testReplacingEndOfString() {
        let input = "Filename.swift"
        let range = input.index(input.endIndex, offsetBy: -6)..<input.endIndex
        let result = input.replacingSubrange(range, with: ".txt")
        #expect(result == "Filename.txt")
    }

    @Test
    func testReplacingEmptyRange() {
        let input = "InsertHere"
        let index = input.index(input.startIndex, offsetBy: 6)
        let result = input.replacingSubrange(index..<index, with: "-")
        #expect(result == "Insert-Here")
    }

    @Test
    func testReplacingFullString() {
        let input = "Old"
        let range = input.startIndex..<input.endIndex
        let result = input.replacingSubrange(range, with: "New")
        #expect(result == "New")
    }
}
