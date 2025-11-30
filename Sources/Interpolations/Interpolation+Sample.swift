//
//  Interpolation+Sample.swift
//  Interpolations
//
//  Created by Gavin Eadie on 2/14/25.
//

import Foundation

/*╭╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╮
  ┆ First let’s declare the basic struct «Sample» and make it ExpressibleByStringLiteral (because    ┆
  ┆ ExpressibleByStringInterpolation inherits that protocol so let’s get that implementation out of  ┆
  ┆ the way) and CustomStringConvertible (for nice debugging when printing in the console)           ┆
  ╰╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╯*/

struct Sample {
    let markdown: String
}

extension Sample: ExpressibleByStringLiteral {
    init(stringLiteral value: String) {
        self.markdown = value
    }
}

extension Sample: CustomStringConvertible {
    var description: String {
        return self.markdown
    }
}

/*╭╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╮
  ┆ Then, we’ll make «Sample» conform to ExpressibleByStringInterpolation, which means having a      ┆
  ┆ StringInterpolation subtype that will handle what to do when:                                    ┆
  ┆                                                                                                  ┆
  ┆ * initializing itself: `init(literalCapacity: Int, interpolationCount: Int)` lets you reserve    ┆
  ┆   some capacity to the buffer you’ll use while building the type step by step. In our case, we   ┆
  ┆   could simply have used a String and append the segments to it while building the instance,     ┆
  ┆   but I instead chose to use a parts: [String], that we’ll assemble together later.              ┆
  ┆                                                                                                  ┆
  ┆ * implement `appendLiteral(_ string: String)` to append the literal text to the parts            ┆
  ┆                                                                                                  ┆
  ┆ * implement `appendInterpolation(user: String)` to append the markdown representation of a       ┆
  ┆   link to that user’s profile when encountering \(user: xxx)                                     ┆
  ┆                                                                                                  ┆
  ┆ * implement `appendInterpolation(issue: Int)` to append the markdown representation of a link    ┆
  ┆   to that issue then implement `init(stringInterpolation: StringInterpolation)` on «Sample» to   ┆
  ┆   build a comment from those parts                                                               ┆
  ┆                                                                                                  ┆
  ┆     let message1: Sample = "See \(issue: 123) where \(user: "gavin") explains ..."               ┆
  ┆                                                                                                  ┆
  ╰╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╯*/

extension Sample: ExpressibleByStringInterpolation {
    struct StringInterpolation: StringInterpolationProtocol {
        var parts: [String]

        init(literalCapacity: Int, interpolationCount: Int) {
            self.parts = []
            // - literalCapacity is the number of characters in literal segments (L)
            // - interpolationCount is the number of interpolation segments (I)
            // We estimate that we generally have a structure like "LILILIL"
            // — e.g. "Hello \(world, .color(.blue))!" — hence the 2n+1
            self.parts.reserveCapacity(2*interpolationCount+1)
        }

        mutating func appendLiteral(_ literal: String) {
            self.parts.append(literal)
        }

        mutating func appendInterpolation(user name: String) {
            self.parts.append("[\(name)](https://github.com/\(name))")
        }

        mutating func appendInterpolation(issue number: Int) {
            self.parts.append("[#\(number)](issues/\(number))")
        }
    }

    init(stringInterpolation: StringInterpolation) {
        self.markdown = stringInterpolation.parts.joined()
    }
}

/*

import Foundation

extension Number.FormatStyle<Int> {
    struct Ordinal: FormatStyle {
        func format(_ value: Int) -> String {
            let suffix: String
            let lastDigit = value % 10
            let lastTwoDigits = value % 100
            
            if (11...13).contains(lastTwoDigits) {
                suffix = "th"
            } else {
                switch lastDigit {
                case 1: suffix = "st"
                case 2: suffix = "nd"
                case 3: suffix = "rd"
                default: suffix = "th"
                }
            }
            
            return "\(value)\(suffix)"
        }
    }
    
    static var ordinal: Ordinal {
        Ordinal()
    }
}

// Usage
let numbers = [1, 2, 3, 4, 11, 21, 22, 23, 101]
for num in numbers {
    print(num.formatted(.ordinal))
}

// Output:
// 1st
// 2nd
// 3rd
// 4th
// 11th
// 21st
// 22nd
// 23rd
// 101st

 */
