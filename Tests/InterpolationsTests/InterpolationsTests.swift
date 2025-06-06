import Foundation
import Testing
@testable import Interpolations

@Test func testCondition() async throws {
    
    struct Sandwich {
        let isStarred: Bool
        let name: String
    }
    
    let bacon = Sandwich(isStarred: true, name: "Bacon")
    #expect("\(bacon.name)\(if: bacon.isStarred, " (*)")" == "Bacon (*)")

    let honey = Sandwich(isStarred: false, name: "Honey")
    #expect("\(honey.name)\(if: honey.isStarred, " (*)")" == "Honey")

}

@Test func testRadix2() async throws {

    let number = 255

    let binaryFormat = IntegerFormatStyle<Int>.radix(2, prefix: "0b")
    let hexFormat = IntegerFormatStyle<Int>.radix(16, uppercase: true, prefix: "0x")
    let octalFormat = IntegerFormatStyle<Int>.radix(8, prefix: "0o")

    print("Binary: \(binaryFormat.format(number))")  // Output: "Binary: 0b11111111"
    print("Hex: \(hexFormat.format(number))")        // Output: "Hex: 0xFF"
    print("Octal: \(octalFormat.format(number))")    // Output: "Octal: 0o377"

}

//    (\(format.index, format: .decimal(minDigits: 3)))    : \
//    \(format.words) = \(value, format: .octal(minDigits: 5))₈

@Test func testIntegers() async throws {
/*╭╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╮
  ┆ binary                                                                                           ┆
  ╰╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╯*/
    #expect("\(1234, .format(radix: .binary))" == "10011010010")
    #expect("\(1234, .format(radix: .binary, minDigits: 8))" == "10011010010")
    #expect("\(1234, .format(radix: .binary, minDigits: 12))" == "010011010010")
    #expect("\(1234, .format(radix: .binary, usesPrefix: true, minDigits: 12))" == "0b010011010010")
    #expect("\(1234, .format(radix: .binary, usesPrefix: true, isBytewise: true, minDigits: 12))" == "0b10011010010")
/*╭╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╮
  ┆ octal                                                                                            ┆
  ╰╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╯*/
    #expect("\(1234, .format(radix: .octal))" == "2322")
    #expect("\(1234, .format(radix: .octal, minDigits: 2))" == "2322")
    #expect("\(1234, .format(radix: .octal, minDigits: 5))" == "02322")
    #expect("\(1234, .format(radix: .octal, usesPrefix: true, minDigits: 5))" == "0o02322")
    #expect("\(1234, .format(radix: .octal, usesPrefix: true, isBytewise: true, minDigits: 5))" == "0o2322")
/*╭╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╮
  ┆ decimal                                                                                          ┆
  ╰╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╯*/
    #expect("\(1234, .format(radix: .decimal))" == "1234")
    #expect("\(1234, .format(radix: .decimal, minDigits: 2))" == "1234")
    #expect("\(1234, .format(radix: .decimal, minDigits: 5))" == "01234")
    #expect("\(1234, .format(radix: .decimal, usesPrefix: true, minDigits: 5))" == "01234")

    #expect("\(-1234, .format(radix: .decimal))" == "-1234")
    #expect("\(-1234, .format(radix: .decimal, minDigits: 6))" == "0-1234")  // negative padding fails
/*╭╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╮
  ┆ hex                                                                                              ┆
  ╰╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╯*/
    #expect("\(1234, .format(radix: .hex))" == "4D2")
    #expect("\(1234, .format(radix: .hex, minDigits: 5))" == "004D2")
    #expect("\(1234, .format(radix: .hex, usesPrefix: true, minDigits: 5))" == "0x004D2")
}

@Test func compare() async throws {

//    let integer: Int = 1234
//    #expect("\(1234, .format(radix: .octal))" == 1234.formatted(IntegerFormatStyle<Int>().radix(8)))
//    #expect("\(integer, .format(radix: .octal))" == integer.formatted(.number.radix(8)))
//    integer.formatted(IntegerFormatStyle<Int>().notation(.radix(8)))

}

@Test func testFloats() async throws {

/*╭╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╮
  ┆ custom formatters (maximumFractionDigits)                                                        ┆
  ╰╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╯*/
    #expect("\(123.456, .format(maxFractionDigits: 0))" == "123", "\(#function)")
    #expect("\(123.456, .format(maxFractionDigits: 1))" == "123.5", "\(#function)")
    #expect("\(123.456, .format(maxFractionDigits: 2))" == "123.46", "\(#function)")
    #expect("\(123.456, .format(maxFractionDigits: 3))" == "123.456", "\(#function)")
    #expect("\(123.456, .format(maxFractionDigits: 99))" == "123.456", "\(#function)")

    print("max Fractions XX: \(123.456, .format(alignment: .center, paddingCharacter: "-", width: 20))")

    print("\(123.456, .format(maxFractionDigits: 2))")

}

@Test func testZeroPads() async throws {

    #expect("\(twoDigits: 5)" == "05")
    #expect("\(twoDigits: 55)" == "55")

    #expect("\(threeDigits: 5)" == "005")
    #expect("\(threeDigits: 55)" == "055")
    #expect("\(threeDigits: 555)" == "555")

    #expect("\(twoDigits: 5.0)" == "05.0")
    #expect("\(twoDigits: 55.0)" == "55.0")

}

@Test func testPadding() async throws {
    
    #expect("\(23, .format(width: 5))" == "   23")
    #expect("\(23, .format(paddingCharacter: "0", width: 5))" == "00023")
    #expect("\(23, .format(alignment: .left, width: 5))" == "23   ")

    #expect("\(23.0, .format(width: 5))" == " 23.0")

    #expect("\(UInt8(23), .format(width: 5))" == "   23")

    print("••• \(#function): pad T \(true, .format(width: 8))")                         // "   23"
    print("••• \(#function): pad F \(false, .format(width: 8))")                        // "   23"

}

@Test func testDates() async throws {

    print("\(Date.now, .format(date: .medium, time: .medium))")

}

@Test func testRadix() async throws {

    print("\(15, .format(radix: .binary, isBytewise: true))")
    print("\(15, .format(radix: .octal, isBytewise: true))")
    print("\(15, .format(radix: .decimal, isBytewise: true))")
    print("\(15, .format(radix: .hex, isBytewise: true))")

    print("\(15, .format(radix: .binary, usesPrefix: true))")
    print("\(15, .format(radix: .octal, usesPrefix: true))")
    print("\(15, .format(radix: .decimal, usesPrefix: true))")
    print("\(15, .format(radix: .hex, usesPrefix: true))")

    print("\(15, .format(radix: .binary, usesPrefix: true, isBytewise: true,                        minDigits: 10))")
    print("\(15, .format(radix: .octal, usesPrefix: true, isBytewise: true,                        minDigits: 10))")
    print("\(15, .format(radix: .decimal, usesPrefix: true, isBytewise: true,                        minDigits: 10))")
    print("\(15, .format(radix: .hex, usesPrefix: true, isBytewise: true,                        minDigits: 10))")

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

//    print("\(Double.pi, formatter: formatter)")
//    print("\(Double(500.0), formatter: formatter)")

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
