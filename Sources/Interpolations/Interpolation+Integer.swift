/*╭╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╮
  ┆ String Interpolations for BinaryInteger (Int, UInt, etc)                                         ┆
  ╰╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╯*/

import Foundation

public extension DefaultStringInterpolation {
    /// Interpolates a binary integer value using the supplied integer formatter,
    /// for example:
    ///
    /// ```
    /// "\(15, .format(radix: .hex))"                                       // F
    /// "\(15, .format(radix: .hex, isBytewise: true))"                     // 0F
    /// "\(15, .format(radix: .hex, usesPrefix: true, isBytewise: true))"   // 0x0F
    /// ```
    ///
    /// - Parameters:
    ///   - value: an integer value
    ///   - formatter: a configured integer formatter
    mutating func appendInterpolation<IntegerValue: BinaryInteger>(_ value: IntegerValue,
                                                                   _ formatter: IntegerFormatter) {
        appendLiteral(formatter.string(from: value))
    }
}

/// A formatter that converts between binary integer values and their textual representations.
public class IntegerFormatter {
    public enum Radix: Int {
        case binary = 2             // a binary number (base 2)
        case octal = 8              // an octal number (base 8)
        case decimal = 10           // a decimal number (base 10)
        case hex = 16               // a hex number (base 16)
        
        /// Returns a radix's optional prefix
        public var prefix: String {
            [
                .binary: "0b",
                .octal: "0o",
                .hex: "0x"
            ][self, default: ""]
        }
    }

    public var radix: Radix = .decimal              // A standard (decimal, binary, octal, or hex) radix
    public var usesPrefix: Bool = false             // Adds an optional prefix (`0b`, `0o`, or `0x`)
    public var explicitPositiveSign: Bool = false   // Forces a "+" on positive values (decimals only)
    public var isBytewise: Bool = false             // 8 numbers for binary, 4 for octal, 2 for hex
    public var minDigits: Int = 0

    public init(radix: Radix = .decimal,
                usesPrefix: Bool = false,
                explicitPositiveSign: Bool = false,
                isBytewise: Bool = false,
                minDigits: Int = 0) {
        (self.radix,
         self.usesPrefix,
         self.explicitPositiveSign,
         self.isBytewise,
         self.minDigits) = (radix,
                            usesPrefix,
                            explicitPositiveSign,
                            isBytewise,
                            minDigits)
    }

    static public func format(radix: Radix = .decimal,
                              usesPrefix: Bool = false,
                              explicitPositiveSign: Bool = false,
                              isBytewise: Bool = false,
                              minDigits: Int = 0
    ) -> IntegerFormatter {
        return IntegerFormatter(radix: radix,
                                usesPrefix: usesPrefix,
                                explicitPositiveSign: explicitPositiveSign,
                                isBytewise: isBytewise,
                                minDigits: minDigits)
    }

    /// Returns a string representing the integer value using the formatter's current settings.
    ///
    /// - Parameter value: a binary integer
    /// - Returns: a formatted string
    func string<IntegerValue: BinaryInteger>(from value: IntegerValue) -> String {
        var string = String(value, radix: radix.rawValue).uppercased()

        // Bytewise strings are padded to 2 for hex, 4 for oct, 8 for binary
        if isBytewise {
            minDigits = [
                Radix.binary: 8,
                .octal: 4,
                .hex: 2
            ][radix, default: minDigits]
        }

        if string.count < minDigits {
            string = String(repeating: "0", count: max(0, minDigits - string.count)) + string
        }

        if usesPrefix { string = radix.prefix + string }

        if explicitPositiveSign && radix == .decimal && value >= 0 { string = "+" + string }

        return string
    }
}

extension IntegerFormatStyle {
    struct Radix: FormatStyle {
        let radix: Int
        let uppercase: Bool
        let prefix: String?
        let suffix: String?

        init(radix: Int, uppercase: Bool = false, prefix: String? = nil, suffix: String? = nil) {
            precondition((2...36).contains(radix), "Radix must be between 2 and 36")
            self.radix = radix
            self.uppercase = uppercase
            self.prefix = prefix
            self.suffix = suffix
        }

        func format(_ value: Int) -> String {
            var formatted = String(value, radix: radix)
            if uppercase {
                formatted = formatted.uppercased()
            }
            return (prefix ?? "") + formatted + (suffix ?? "")
        }
    }

    static func radix(_ radix: Int, uppercase: Bool = false, prefix: String? = nil, suffix: String? = nil) -> Radix {
        Radix(radix: radix, uppercase: uppercase, prefix: prefix, suffix: suffix)
    }
}

/*

 IntegerFormatStyle -- let formattedDefault = 123456.formatted()

 decimalSeparator
 grouping
 locale
 notation
 precision
 rounded
 scale
 sign
 (not radix)
 (not padded)

 */


//    Usage
//    let number = 42
//    let paddedNumber = number.formatted(.padded(length: 5))
//    print("Padded Number: \(paddedNumber)") // Output: "00042"


//import Foundation
//
//extension Number.FormatStyle<Int> {
//
//    struct RadixStyle: FormatStyle {
//        typealias FormatInput = Int
//        typealias FormatOutput = String
//
//        func format(_ value: Int) -> String {
//            String(String(value).reversed())
//        }
//    }
//
//    struct Padded: FormatStyle {
//        let length: Int
//
//        func format(_ value: Int) -> String {
//            String(format: "%0\(length)d", value)
//        }
//    }
//
//    static func padded(length: Int) -> Padded {
//        Padded(length: length)
//    }
//
//}

//    extension FormatStyle where Self == RadixStyle {
//        static var reversed: RadixStyle { .init() }
//    }



//        25.formatted(.reversed) // "25"
//        (-42).formatted(.reversed) // "24-"



/// Extending default string interpolation behavior
/// ===============================================
///
/// Code outside the standard library can extend string interpolation on
/// `String` and many other common types by extending
/// `DefaultStringInterpolation` and adding an `appendInterpolation(...)`
/// method. For example:
///
///     extension DefaultStringInterpolation {
///         fileprivate mutating func appendInterpolation(
///                  escaped value: String, asASCII forceASCII: Bool = false) {
///             for char in value.unicodeScalars {
///                 appendInterpolation(char.escaped(asASCII: forceASCII))
///             }
///         }
///     }
///
///     print("Escaped string: \(escaped: string)")
///
/// See `StringInterpolationProtocol` for details on `appendInterpolation`
/// methods.
///
/// `DefaultStringInterpolation` extensions should add only `mutating` members
/// and should not copy `self` or capture it in an escaping closure.
