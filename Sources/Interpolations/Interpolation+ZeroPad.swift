extension DefaultStringInterpolation {
    /// Interpolates a small integer number to two digits prependings "0" ..
    ///
    /// - Parameters:
    ///   - value: an integer
    mutating func appendInterpolation(twoDigits value: Int) {
        appendInterpolation((value < 10 ? "0" : "") + String(value))
    }

    /// Interpolates a small integer number to three digits prependings "0" ..
    ///
    /// - Parameters:
    ///   - value: an integer
    mutating func appendInterpolation(threeDigits value: Int) {
        switch value {
            case 0..<10:
                appendInterpolation("00" + String(value))
            case 10..<100:
                appendInterpolation("0" + String(value))
            default:
                appendInterpolation(String(value))
        }
    }

    /// Interpolates a small floating point number to two digits prependings "0" ..
    ///
    /// - Parameters:
    ///   - value: an Double
    mutating func appendInterpolation(twoDigits value: Double) {
        appendInterpolation((value < 10.0 ? "0" : "") + String(value))
    }
}

