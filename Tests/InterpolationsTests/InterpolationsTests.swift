import Foundation
import Testing
@testable import Interpolations

@Test func testCondition() async throws {
    
    struct Sandwich {
        let isStarred: Bool
        let name: String
    }
    
    let sandwich1 = Sandwich(isStarred: true, name: "Bacon")
    print("Sandwich: \(sandwich1.name) \(if: sandwich1.isStarred, " (*)")")

    let sandwich2 = Sandwich(isStarred: false, name: "  Ham")
    print("Sandwich: \(sandwich2.name) \(if: sandwich2.isStarred, " (*)")")
    
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
    
    print("\(23, .format(width: 5))")                           // "   23"
    print("\(23, .format(paddingCharacter: "0", width: 5))")    // "00023"
    print("\(23, .format(alignment: .left, width: 5))")         // "23   "
    
    print("\(23.0, .format(width: 5))")                         // " 23.0"
    
    print("\(UInt8(23), .format(width: 5))")                    // "   23"

    print("pad T \(true, .format(width: 8))")                         // "   23"
    print("pad F \(false, .format(width: 8))")                        // "   23"

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

@Test func testOptional() async throws {
    
    var optional: Int? = nil
    print("\(optional, default: "-NIL-")")
    
    optional = 1
    print("\(optional, default: "-NIL-")")
    
    //---
    
    let value1: Int? = 23
    let value2: Int? = nil
    
    print("[opt-1]: \(value1, .format(style: .default)) and \(value2, .format(style: .default))")
    
    // "There's Optional(23) and Optional(nil)"
    print("[opt-2]: \(value1, .format(style: .descriptive)) and \(value2, .format(style: .descriptive))")
    
    // "There's 23 and nil"
    print("[opt-3a]: \(value1, .format(style: .stripped)) and \(value2, .format(style: .stripped))")
    print("[opt-3b]: \(value1, .format()) and \(value2, .format())")
    
    //---
    
    print("none \(0, zero: "ZERO", one: "ONE", many: "MANY")")
    print(" one \(1, zero: "ZERO", one: "ONE", many: "MANY")")
    print("many \(2, zero: "ZERO", one: "ONE", many: "MANY")")
    
}
