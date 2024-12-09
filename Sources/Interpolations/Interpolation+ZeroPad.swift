// The Swift Programming Language
// https://docs.swift.org/swift-book

extension DefaultStringInterpolation {
    mutating func appendInterpolation(twoDigits value: Int) {
        appendInterpolation((value < 10 ? "0" : "") + String(value))
    }
}

extension DefaultStringInterpolation {
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

extension DefaultStringInterpolation {
    mutating func appendInterpolation(twoDigits value: Double) {
        appendInterpolation((value < 10.0 ? "0" : "") + String(value))
    }
}