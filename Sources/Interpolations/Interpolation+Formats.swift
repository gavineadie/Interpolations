import Foundation

// Thanks Brent Royal-Gordan
public extension String.StringInterpolation {
    mutating func appendInterpolation<Value: _ObjectiveCBridgeable>(_ value: Value,
                             formatter: NumberFormatter) where Value._ObjectiveCType == NSNumber {
        if let string = formatter.string(from: NSNumber(nonretainedObject: value)) {
            appendLiteral(string)
        } else {
            appendLiteral("Unformattable<\(value)>")
        }
    }
}

public extension String.StringInterpolation {

    /// Interpolates a floating point value using a number formatter.
    mutating func appendInterpolation<Value: FloatingPoint>(_ number: Value,
                                                                   formatter: NumberFormatter) {
        if
            let value = number as? NSNumber,
            let string = formatter.string(from: value) {
            appendLiteral(string)
        } else {
            appendLiteral("Unformattable<\(number)>")
        }
    }
    
    /// Interpolates an integer value using a number formatter.
    mutating func appendInterpolation<Value: BinaryInteger>(_ number: Value,
                                                                   formatter: NumberFormatter) {
        if
            let value = number as? NSNumber,
            let string = formatter.string(from: value) {
            appendLiteral(string)
        } else {
            appendLiteral("Unformattable<\(number)>")
        }
    }
}
