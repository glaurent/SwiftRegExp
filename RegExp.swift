//
//  RegExp.swift
//  SwiftRegExp
//
//  Created by Guillaume Laurent on 01/04/15.
//  Copyright (c) 2015 Guillaume Laurent. All rights reserved.
//

import Foundation

/**
* Swift wrapper over NSRegularExpression, aiming at giving a Ruby-like API for RegExps.
* Inspired by http://benscheirman.com/2014/06/regex-in-swift/
*/
class RegExp: NSObject {

    var regexp:NSRegularExpression!

    /// failable init - will return nil if regexp syntax is misformed
    init?(pattern:String, options:NSRegularExpressionOptions) {
        var error:NSError?

        var testRegExp = NSRegularExpression(pattern: pattern, options: options, error: &error)

        if error != nil {
            super.init() // see https://devforums.apple.com/message/1113604#1113604 - known limitation of failable initializers as of Swift 1.2
            return nil
        }

        regexp = testRegExp
        super.init()
    }

    /// simple boolean match test
    func isMatching(string:String) -> Bool {

        let allStringRange = fullRangeForString(string)

        let nbMatches = regexp.numberOfMatchesInString(string, options: NSMatchingOptions(0), range: fullRangeForString(string))

        return nbMatches > 0
    }

    /// returns the matching part of a String
    func match(string:String) -> String? {
        let allStringRange = fullRangeForString(string)

        if let res = regexp.firstMatchInString(string, options: NSMatchingOptions(0), range: allStringRange) {
            let stringAsNS = string as NSString
            let firstMatch = stringAsNS.substringWithRange(res.range)
            return firstMatch
        } else {
            return nil
        }
    }

    /// returns all matches (including capture groups) as an array of String
    func allMatches(string:String) -> [String] {

        var matches = [String]()

        let stringAsNS = string as NSString

        regexp.enumerateMatchesInString(string, options: NSMatchingOptions(0), range: fullRangeForString(string)) {
            (textCheckingResult:NSTextCheckingResult!, flags:NSMatchingFlags, stop:UnsafeMutablePointer<ObjCBool>) -> Void in

            for i in 0..<textCheckingResult.numberOfRanges {

                let subMatch = stringAsNS.substringWithRange(textCheckingResult.rangeAtIndex(i))
                matches.append(subMatch as String)
            }
        }

        return matches
    }

    private func fullRangeForString(string:String) -> NSRange {
        return NSRange(location:0, length:count(string))
    }
}

/// Some operator overloading
infix operator =~ {}

func =~ (left:String, right:RegExp) -> String? {
    return right.match(left)
}

func =~ (left:RegExp, right:String) -> String? {
    return left.match(right)
}


