public extension DefaultStringInterpolation {
    /// interpolation that succeeds only when the `condition` evaluates to true
    ///
    /// For example,
    ///
    /// ```
    /// "Premiere Cheese Sandwich\(if: sandwich.IsStarred, " (*)")"
    /// ```
    ///
    /// - Parameters:
    ///   - condition: a Boolean predicate that evaluates to true or false
    ///   - literal: a `String` literal to include on conditional success
    mutating func appendInterpolation(if condition: @autoclosure () -> Bool,
                                      _ literal: StringLiteralType) {
        if condition() { appendLiteral(literal) }
    }
}
