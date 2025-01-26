import Foundation

public extension DefaultStringInterpolation {
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
    /// Returns an initialized `NumberFormatter` for "±1234.5" ..
    ///
    /// - Parameters:
    ///   - maxFractionDigits: number of fractional digits (1)
    /// - Returns: an initialized number formatter
    static func format(maxFractionDigits: UInt = 1) -> NumberFormatter {
        let numberFormatter = NumberFormatter()

        numberFormatter.minimumIntegerDigits = 1
        numberFormatter.maximumFractionDigits = Int(maxFractionDigits)
        numberFormatter.usesGroupingSeparator = false

        return numberFormatter
    }
}
