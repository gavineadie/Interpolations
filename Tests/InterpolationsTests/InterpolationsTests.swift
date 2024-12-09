import Foundation
import Testing
@testable import Interpolations

@Test func testIf() async throws {
    
    struct Sandwich {
        let isStarred: Bool
        let name = "Cheese"
    }
    
    let sandwich1 = Sandwich(isStarred: true)
    print("Cheese Sandwich\(if: sandwich1.isStarred, " (*)")")
    
    let sandwich2 = Sandwich(isStarred: false)
    print("Cheese Sandwich\(if: sandwich2.isStarred, " (*)")")
    
}

@Test func testZeroPads() async throws {
    
    print("\(twoDigits: 5)")
    print("\(twoDigits: 55)")

    print("\(threeDigits: 5)")
    print("\(threeDigits: 55)")
    print("\(threeDigits: 555)")

    print("\(twoDigits: 5.0)")
    print("\(twoDigits: 55.0)")

}

@Test func testPadding() async throws {
    
    print("\(23, .format(width: 5))")                       // "   23"
    print("\(23, .format(alignment: .left, width: 5))")     // "23   "

    print("\(23.0, .format(width: 5))")                     // " 23.0"

}

@Test func testDates() async throws {
    
    print("\(Date.now, .format(date: .medium, time: .medium))")

}

@Test func testRadix() async throws {
    
    print("\(15, .format(radix: .binary, usesPrefix: true, isBytewise: true))")
    
}

@Test func testFormatter() async throws {
    
    let formatter = NumberFormatter()

    formatter.localizesFormat = true
    formatter.roundingMode = .halfUp
    formatter.usesSignificantDigits = true
    formatter.maximumSignificantDigits = 8
    formatter.minimumSignificantDigits = 8
    formatter.minimumFractionDigits = 1
    formatter.maximumFractionDigits = 4
    formatter.paddingPosition = .beforePrefix
    formatter.paddingCharacter = "0"
    formatter.minimumIntegerDigits = 5

    print("\(Double.pi, formatter: formatter)")
    print("\(500, formatter: formatter)")

}
