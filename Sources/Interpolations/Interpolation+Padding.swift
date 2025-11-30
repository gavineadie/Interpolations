// MARK: - Padding Interpolation

public extension DefaultStringInterpolation {
    /// Interpolates a value using a custom string formatter, allowing padding and alignment.
    ///
    /// Example usage:
    /// ```swift
    /// "\(23, .format(width: 5))"                    // "   23"
    /// "\(23, .format(alignment: .left, width: 5))"  // "23   "
    /// ```
    ///
    /// - Parameters:
    ///   - value: The value to format and interpolate.
    ///   - formatter: The string formatter that controls padding, alignment, and width.
    ///   - width: An optional minimum width that overrides the formatter's width if nonzero.
 	mutating func appendInterpolation<Value>(
        _ value: Value,
        _ formatter: StringFormatter,
        width: Int = 0
    ) {
        if width != 0 { formatter.width = width }
        appendLiteral(formatter.string(from: "\(value)"))
    }
}

/// A formatter that adjusts string layout.
public class StringFormatter {
    /// The direction from which a string floats when padded with repeated characters.
    public enum TextAlignment { case left, right, center }

    /// The alignment of the formatted text. Default is `.right`.
    public var alignment: TextAlignment

    /// The character used for padding. Default is a space.
    public var paddingCharacter: Character

    /// The minimum width of the resulting string. Default is zero.
    public var width: Int

    /// Creates a new `StringFormatter`.
    ///
    /// - Parameters:
    ///   - alignment: The alignment of the text within the padded output.
    ///   - paddingCharacter: The character used to pad the text.
    ///   - width: The minimum width of the output string.
    public init(
        alignment: TextAlignment = .right,
        paddingCharacter: Character = " ",
        width: Int = 0
    ) {
        self.alignment = alignment
        self.paddingCharacter = paddingCharacter
        self.width = width
    }

    /// Creates a configured `StringFormatter`.
    ///
    /// - Parameters:
    ///   - alignment: The alignment of the text within the padded output.
    ///   - paddingCharacter: The character used to pad the text.
    ///   - width: The minimum width of the output string.
    /// - Returns: A configured `StringFormatter`.
    public static func format(
        alignment: TextAlignment = .right,
        paddingCharacter: Character = " ",
        width: Int = 0
    ) -> StringFormatter {
        return StringFormatter(alignment: alignment, paddingCharacter: paddingCharacter, width: width)
    }

    /// Returns a padded and aligned string based on the formatter's settings.
    ///
    /// - Parameter string: The original string to format.
    /// - Returns: The formatted string with padding applied.
    public func string(from string: StringLiteralType) -> StringLiteralType {
        guard width > string.count else { return string }
        let paddingCount = width - string.count

        func padding(_ count: Int) -> String {
            String(repeating: paddingCharacter, count: count)
        }

        switch alignment {
        case .right:
            return padding(paddingCount) + string
        case .left:
            return string + padding(paddingCount)
        case .center:
            let halfPad = paddingCount / 2
            return padding(paddingCount - halfPad) + string + padding(halfPad)
        }
    }
}
