import Foundation

// Thanks Brent Royal-Gordan
extension DefaultStringInterpolation {
    mutating func appendInterpolation<Value: _ObjectiveCBridgeable>(_ value: Value,
                             formatter: NumberFormatter) where Value._ObjectiveCType == NSNumber {
        if let string = formatter.string(from: NSNumber(nonretainedObject: value)) {
            appendLiteral(string)
        } else {
            appendLiteral("Unformattable<\(value)>")
        }
    }
}

extension DefaultStringInterpolation {
    /// Interpolates an integer value using a number formatter.
    mutating func appendInterpolation<IntegerValue: BinaryInteger>(_ number: IntegerValue,
                                                            formatter: NumberFormatter) {
        if let value = number as? NSNumber, let string = formatter.string(from: value) {
            appendLiteral(string)
        } else {
            appendLiteral("Unformattable<\(number)>")
        }
    }
}
