// MARK: - Conditional String Interpolation Extension

public extension DefaultStringInterpolation {
    /// Interpolates the string only when the `condition` evaluates to true.
    ///
    /// For example:
    ///
    /// ```swift
    /// "Premiere Cheese Sandwich\(if: sandwich.isStarred, " (*)")"
    /// ```
    ///
    /// - Parameters:
    ///   - condition: A Boolean predicate. If true, the literal is included.
    ///   - literal: The string to include when the condition is true.
    ///   - Note: The `condition` is an `@autoclosure`, so you can simply write a Boolean expression directly.
    mutating func appendInterpolation(if condition: @autoclosure () -> Bool,
                                             _ literal: StringLiteralType) {
        if condition() { appendLiteral(literal) }
    }
}
