/*╭╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╮
  ┆ String Interpolations for BinaryInteger (Int, UInt, etc)                                         ┆
  ╰╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╯*/

import Foundation

public extension DefaultStringInterpolation {
    // MARK: - Integer Interpolation

    /// Interpolates a binary integer value using the supplied `IntegerFormatter`.
    ///
    /// Examples:
    /// ```swift
    /// "\(15, .format(radix: .hex))"                // "F"
    /// "\(15, .format(radix: .hex, isBytewise: true))" // "0F"
    /// "\(15, .format(radix: .hex, usesPrefix: true, isBytewise: true))" // "0x0F"
    /// ```
    ///
    /// - Parameters:
    ///   - value: The integer value to format.
    ///   - formatter: The configured `IntegerFormatter` instance.
    mutating func appendInterpolation<IntegerValue: BinaryInteger>(_ value: IntegerValue,
                                                                   _ formatter: IntegerFormatter) {
        appendLiteral(formatter.string(from: value))
    }
}

// MARK: - IntegerFormatter

/// A formatter that converts binary integer values into textual representations.
///
/// Supports formatting with different radices, optional prefixes, explicit positive signs,
/// bytewise padding, and minimum digit counts.
public class IntegerFormatter {

    /// Radix (base) options for integer formatting.
    public enum Radix: Int {
        case binary = 2   // Binary (base 2)
        case octal = 8    // Octal (base 8)
        case decimal = 10 // Decimal (base 10)
        case hex = 16     // Hexadecimal (base 16)

        /// Optional prefix for the radix.
        public var prefix: String {
            switch self {
            case .binary: return "0b"
            case .octal: return "0o"
            case .hex: return "0x"
            default: return ""
            }
        }
    }

    /// The radix (base) used for formatting. Default is `.decimal`.
    public var radix: Radix = .decimal

    /// Whether to prepend the radix prefix (`0b`, `0o`, `0x`). Defaults to `false`.
    public var usesPrefix: Bool = false

    /// Whether to include an explicit "+" sign for positive decimal numbers. Defaults to `false`.
    public var explicitPositiveSign: Bool = false

    /// Whether to pad digits bytewise: 8 digits for binary, 4 for octal, 2 for hex. Defaults to `false`.
    public var isBytewise: Bool = false

    /// The minimum number of digits to display. Defaults to 0.
    public var minDigits: Int = 0

    /// Initializes a new integer formatter.
    ///
    /// - Parameters:
    ///   - radix: The radix (base) to use.
    ///   - usesPrefix: Whether to add the prefix string.
    ///   - explicitPositiveSign: Whether to prepend "+" on positive decimal numbers.
    ///   - isBytewise: Whether to pad digits bytewise.
    ///   - minDigits: Minimum number of digits to display.
    public init(radix: Radix = .decimal,
                usesPrefix: Bool = false,
                explicitPositiveSign: Bool = false,
                isBytewise: Bool = false,
                minDigits: Int = 0) {
        self.radix = radix
        self.usesPrefix = usesPrefix
        self.explicitPositiveSign = explicitPositiveSign
        self.isBytewise = isBytewise
        self.minDigits = minDigits
    }

    /// Factory method to create an `IntegerFormatter` with specified options.
    ///
    /// - Parameters:
    ///   - radix: The radix (base) to use.
    ///   - usesPrefix: Whether to add the prefix string.
    ///   - explicitPositiveSign: Whether to prepend "+" on positive decimal numbers.
    ///   - isBytewise: Whether to pad digits bytewise.
    ///   - minDigits: Minimum number of digits to display.
    /// - Returns: A configured `IntegerFormatter` instance.
    public static func format(radix: Radix = .decimal,
                              usesPrefix: Bool = false,
                              explicitPositiveSign: Bool = false,
                              isBytewise: Bool = false,
                              minDigits: Int = 0) -> IntegerFormatter {
        IntegerFormatter(radix: radix,
                         usesPrefix: usesPrefix,
                         explicitPositiveSign: explicitPositiveSign,
                         isBytewise: isBytewise,
                         minDigits: minDigits)
    }

    /// Returns a formatted string representation of the given integer value.
    ///
    /// - Parameter value: The integer value to format.
    /// - Returns: The formatted string.
    func string<IntegerValue: BinaryInteger>(from value: IntegerValue) -> String {
        var string = String(value, radix: radix.rawValue).uppercased()

        if isBytewise {
            minDigits = [
                .binary: 8,
                .octal: 4,
                .hex: 2
            ][radix, default: minDigits]
        }

        if string.count < minDigits {
            string = String(repeating: "0", count: max(0, minDigits - string.count)) + string
        }

        if usesPrefix {
            string = radix.prefix + string
        }

        if explicitPositiveSign && radix == .decimal && value >= 0 {
            string = "+" + string
        }

        return string
    }
}

// MARK: - IntegerFormatStyle Radix Extension

extension IntegerFormatStyle {
    /// A format style for representing integers in a specified radix.
    struct Radix: FormatStyle {
        let radix: Int
        let uppercase: Bool
        let prefix: String?
        let suffix: String?

        /// Creates a new radix format style.
        ///
        /// - Parameters:
        ///   - radix: The integer base between 2 and 36.
        ///   - uppercase: Whether to uppercase letters (for bases > 10).
        ///   - prefix: Optional string to prepend.
        ///   - suffix: Optional string to append.
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

    /// Creates a radix format style.
    ///
    /// - Parameters:
    ///   - radix: The integer base (2...36).
    ///   - uppercase: Whether to uppercase letters.
    ///   - prefix: Optional prefix string.
    ///   - suffix: Optional suffix string.
    /// - Returns: A configured radix format style.
    static func radix(_ radix: Int, uppercase: Bool = false, prefix: String? = nil, suffix: String? = nil) -> Radix {
        Radix(radix: radix, uppercase: uppercase, prefix: prefix, suffix: suffix)
    }
}

// MARK: - Documentation

/*
 This module extends String interpolation to support binary integer formatting 
 using customizable `IntegerFormatter` instances.

 The `IntegerFormatter` supports:
 - radix selection (binary, octal, decimal, hex)
 - optional prefixes (e.g., "0x" for hex)
 - explicit positive sign for decimal values
 - bytewise padding (e.g., 8 digits for binary)
 - minimum digit count padding

 Usage example:

     let value = 15
     print("\(value, .format(radix: .hex))")                     // "F"
     print("\(value, .format(radix: .hex, isBytewise: true))")   // "0F"
     print("\(value, .format(radix: .hex, usesPrefix: true, isBytewise: true))") // "0x0F"
*/
