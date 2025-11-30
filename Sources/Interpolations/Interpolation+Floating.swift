/*╭╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╮
  ┆ String Interpolations for BinaryFloatingPoint (Double, Float, etc)                               ┆
  ╰╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╯*/

import Foundation

// MARK: - Floating-Point Interpolation

public extension DefaultStringInterpolation {
    /// Interpolates a `Double` value using the specified `NumberFormatter`.
    ///
    /// This allows formatting floating-point numbers in string interpolations
    /// with custom formatting styles provided by `NumberFormatter`.
    ///
    /// - Parameters:
    ///   - number: The `Double` value to interpolate.
    ///   - formatter: A configured `NumberFormatter` instance used to format the number.
    ///
    /// Example usage:
    /// ```swift
    /// let formatter = NumberFormatter.format(maxFractionDigits: 2)
    /// let value: Double = 3.14159
    /// let result = "\(value, formatter)" // "3.14"
    /// ```
    mutating func appendInterpolation(_ number: Double, _ formatter: NumberFormatter) {
        if let formattedString = formatter.string(from: number as NSNumber) {
            appendLiteral(formattedString)
        } else {
            appendLiteral("Unformattable<\(number)>")
        }
    }
}

// MARK: - NumberFormatter Convenience

public extension NumberFormatter {
    /// Creates and returns a configured `NumberFormatter` instance with no grouping separator
    /// and a specified maximum number of fractional digits.
    ///
    /// - Parameter maxFractionDigits: The maximum number of digits after the decimal point. Default is 1.
    /// - Returns: A configured `NumberFormatter` instance.
    ///
    /// Example usage:
    /// ```swift
    /// let formatter = NumberFormatter.format(maxFractionDigits: 3)
    /// let formatted = formatter.string(from: 1234.56789) // "1234.568"
    /// ```
    static func format(maxFractionDigits: UInt = 1) -> NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.minimumIntegerDigits = 1
        numberFormatter.maximumFractionDigits = Int(maxFractionDigits)
        numberFormatter.usesGroupingSeparator = false
        return numberFormatter
    }
}
