import Foundation

// MARK: - Date Interpolation

public extension DefaultStringInterpolation {
    /// Interpolates a `Date` using the specified `DateFormatter`.
    ///
    /// This allows you to include formatted date strings directly within string
    /// interpolations, for example:
    ///
    /// ```swift
    /// let date = Date()
    /// let formatter = DateFormatter.format(date: .short, time: .short)
    /// print("Current date and time: \(date, formatter)")
    /// ```
    ///
    /// - Parameters:
    ///   - value: The `Date` to format.
    ///   - formatter: The `DateFormatter` instance used to format the date.
    mutating func appendInterpolation(_ value: Date, _ formatter: DateFormatter) {
        appendLiteral(formatter.string(from: value))
    }
}

// MARK: - DateFormatter Convenience

public extension DateFormatter {
    /// Creates a new `DateFormatter` configured with the specified date and time styles,
    /// using the current locale.
    ///
    /// Usage example:
    ///
    /// ```swift
    /// let formatter = DateFormatter.format(date: .medium, time: .short)
    /// let formatted = formatter.string(from: Date())
    /// ```
    ///
    /// - Parameters:
    ///   - date: The desired `DateFormatter.Style` for the date portion.
    ///   - time: The desired `DateFormatter.Style` for the time portion.
    /// - Returns: A new `DateFormatter` instance with the given styles and current locale.
    static func format(date: Style, time: Style) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        (formatter.dateStyle, formatter.timeStyle) = (date, time)
        return formatter
    }
}
