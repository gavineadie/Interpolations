import Foundation

extension DefaultStringInterpolation {
    /// Interpolates a BinaryFloatingPoint using the supplied NumberFormatter, for example:
    ///
    /// - Parameters:
    ///   - value: an floating point value
    ///   - formatter: a configured number formatter
    mutating func appendInterpolation(_ number: Double,
                                      _ formatter: NumberFormatter) {
        if let string = formatter.string(from: number as NSNumber) {
            appendLiteral(string)
        } else {
            appendLiteral("Unformattable<\(number)>")
        }
    }
}

public extension NumberFormatter {
    /// Returns an initialized `NumberFormatter` instance using the supplied date and time styles.
    ///
    /// - Parameters:
    /// - Returns: an initialized number formatter using the current locale
    static func format(maxFracts: UInt) -> NumberFormatter {
        let numberFormatter = NumberFormatter()

        numberFormatter.minimumIntegerDigits = 1
        numberFormatter.maximumFractionDigits = Int(maxFracts)
        numberFormatter.usesGroupingSeparator = false

        return numberFormatter
    }
}
