// MARK: - Optional Value String Interpolation

public extension DefaultStringInterpolation {
    /// Interpolates an optional value, providing a custom default for `nil`.
    ///
    /// - Parameters:
    ///   - value: The optional value to interpolate for the `.some` case.
    ///   - defaultValue: The string to present for `.none` (nil).
    ///
    /// Example:
    /// ```swift
    /// "Count: \(myInt?, default: "none")"
    /// ```
    mutating func appendInterpolation(_ value: String?, default defaultValue: String) {
        appendLiteral(value ?? defaultValue)
    }
    
    mutating func appendInterpolation<Wrapped: CustomStringConvertible>(_ value: Wrapped?, default defaultValue: String) {
        if let value {
            appendLiteral(String(describing: value))
        } else {
            appendLiteral(defaultValue)
        }
    }
    
    mutating func appendInterpolation<Wrapped>(_ value: Wrapped?, nilText defaultValue: String) {
        if let value {
            appendInterpolation(value)
        } else {
            appendLiteral(defaultValue)
        }
    }
}

// MARK: - Optional Value Interpolation with Style

public extension DefaultStringInterpolation {
    /// Interpolates an optional value using a supplied formatter for style.
    ///
    /// Example:
    /// ```swift
    /// "There's \(value1, .format(style: .default)) and \(value2, .format(style: .default))"
    /// "There's \(value1, .format(style: .stripped)) and \(value2, .format(style: .stripped))"
    /// ```
    ///
    /// - Parameters:
    ///   - value: The optional value for interpolation.
    ///   - formatter: An `OptionalFormatter` instance to determine style.
    mutating func appendInterpolation<Wrapped>(_ value: Wrapped?, _ formatter: OptionalFormatter) {
        appendLiteral(formatter.string(from: value))
    }
}

// MARK: - OptionalFormatter for Customizing Optional Interpolation

/// Formats optional values for string interpolation using different styles.
public class OptionalFormatter {
    /// Styles for presenting optional values in interpolation.
    public enum OptionalStyle {
        /// Includes `Optional` for both `.some` and `.none`
        case descriptive
        /// No `Optional` in output at all
        case stripped
        /// System default: `Optional(x)` for `.some`, just default for `.none`
        case system
        /// Alias for `.system`
        case `default`
    }

    /// The style used to present the optional value.
    public var style: OptionalStyle = .stripped
    /// The fallback text to use for `.none` case.
    public var defaultValue: String = "nil"

    /// Creates an `OptionalFormatter` with the given style and default value.
    ///
    /// - Parameters:
    ///   - style: The style to apply when formatting optional values.
    ///   - default: The string to use when the value is `.none`.
    public init(style: OptionalStyle = .stripped, default: String = "nil") {
        (self.style, self.defaultValue) = (style, `default`)
    }

    /// Returns a configured formatter instance.
    ///
    /// - Parameters:
    ///   - style: The style to apply when formatting optional values.
    ///   - default: The string to use when the value is `.none`.
    /// - Returns: A configured `OptionalFormatter`.
    public static func format(style: OptionalStyle = .stripped, default: String = "nil") -> OptionalFormatter {
        OptionalFormatter(style: style, default: `default`)
    }

    /// Returns a formatted string representing the optional value.
    ///
    /// - Parameter value: The optional value to format.
    /// - Returns: A string formatted according to the formatter's style.
    public func string<Wrapped>(from value: Wrapped?) -> String {
        switch style {
        case .descriptive:
            return value == nil ? "Optional(\(defaultValue))" : String(describing: value)
        case .stripped:
            return value.map { "\($0)" } ?? defaultValue
        case .system, .default:
            return value != nil ? String(describing: value) : defaultValue
        }
    }
}

// MARK: - Noun Pluralization String Interpolation

public extension String.StringInterpolation {
    /// Interpolates noun forms for zero, one, and many cases based on integer value.
    ///
    /// - Parameters:
    ///   - value: The integer value to determine pluralization.
    ///   - zero: The string to use when `value` is zero.
    ///   - one: The string to use when `value` is one.
    ///   - many: The string to use for all other values.
    ///
    /// Example:
    /// ```swift
    /// "You have \(count, zero: "none", one: "one", many: "many") apples."
    /// ```
    mutating func appendInterpolation(_ value: Int, zero: String, one: String, many: String) {
        switch value {
        case 0: appendLiteral(zero)
        case 1: appendLiteral(one)
        default: appendLiteral(many)
        }
    }
}

