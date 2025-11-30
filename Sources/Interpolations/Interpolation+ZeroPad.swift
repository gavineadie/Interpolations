public extension DefaultStringInterpolation {
    // MARK: - Two Digit Interpolation

    /// Interpolates an integer to a two-digit string, prepending a "0" if needed.
    ///
    /// Example:
    /// ```swift
    /// let value = 7
    /// print("\(twoDigits: value)") // "07"
    /// ```
    ///
    /// - Parameter value: The integer to format.
    mutating func appendInterpolation(twoDigits value: Int) {
        appendInterpolation((value < 10 ? "0" : "") + String(value))
    }

    /// Interpolates a floating-point number to a two-digit string, prepending a "0" if needed.
    ///
    /// Example:
    /// ```swift
    /// let value = 4.5
    /// print("\(twoDigits: value)") // "04.5"
    /// ```
    ///
    /// - Parameter value: The double to format.
    mutating func appendInterpolation(twoDigits value: Double) {
        appendInterpolation((value < 10.0 ? "0" : "") + String(value))
    }

    // MARK: - Three Digit Interpolation

    /// Interpolates an integer to a three-digit string, prepending zeros if needed.
    ///
    /// Examples:
    /// ```swift
    /// let a = 7
    /// print("\(threeDigits: a)") // "007"
    /// let b = 45
    /// print("\(threeDigits: b)") // "045"
    /// let c = 123
    /// print("\(threeDigits: c)") // "123"
    /// ```
    ///
    /// - Parameter value: The integer to format.
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
}
