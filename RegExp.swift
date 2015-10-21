//
//  RegExp.swift
//  SwiftRegExp
//
//  Created by Guillaume Laurent on 01/04/15.
//  Copyright (c) 2015 Guillaume Laurent. All rights reserved.
//
/* BSD license follows (http://www.opensource.org/licenses/bsd-license.php)
*
*
* Redistribution and use in source and binary forms, with or without modification,
* are permitted provided that the following conditions are met:
*
* Redistributions of  source code  must retain  the above  copyright notice,
* this list of  conditions and the following  disclaimer. Redistributions in
* binary  form must  reproduce  the  above copyright  notice,  this list  of
* conditions and the following disclaimer  in the documentation and/or other
* materials  provided with  the distribution.  Neither the  name of  Florent
* Pillet nor the names of its contributors may be used to endorse or promote
* products  derived  from  this  software  without  specific  prior  written
* permission.  THIS  SOFTWARE  IS  PROVIDED BY  THE  COPYRIGHT  HOLDERS  AND
* CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT
* NOT LIMITED TO, THE IMPLIED  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
* A  PARTICULAR PURPOSE  ARE DISCLAIMED.  IN  NO EVENT  SHALL THE  COPYRIGHT
* HOLDER OR  CONTRIBUTORS BE  LIABLE FOR  ANY DIRECT,  INDIRECT, INCIDENTAL,
* SPECIAL, EXEMPLARY,  OR CONSEQUENTIAL DAMAGES (INCLUDING,  BUT NOT LIMITED
* TO, PROCUREMENT  OF SUBSTITUTE GOODS  OR SERVICES;  LOSS OF USE,  DATA, OR
* PROFITS; OR  BUSINESS INTERRUPTION)  HOWEVER CAUSED AND  ON ANY  THEORY OF
* LIABILITY,  WHETHER  IN CONTRACT,  STRICT  LIABILITY,  OR TORT  (INCLUDING
* NEGLIGENCE  OR OTHERWISE)  ARISING  IN ANY  WAY  OUT OF  THE  USE OF  THIS
* SOFTWARE,   EVEN  IF   ADVISED  OF   THE  POSSIBILITY   OF  SUCH   DAMAGE.
*
*/

import Foundation

/**
* Swift wrapper over NSRegularExpression, aiming at giving a Ruby-like API for RegExps.
* Inspired by http://benscheirman.com/2014/06/regex-in-swift/
*/
public class RegExp: NSObject {

    var regexp = NSRegularExpression()

    /// failable init - will return nil if regexp syntax is misformed
    public init?(pattern:String, options:NSRegularExpressionOptions) throws {

        super.init()

        regexp = try NSRegularExpression(pattern: pattern, options: options)
    }

    /// simple boolean match test
    public func isMatching(string:String) -> Bool {

        let nbMatches = regexp.numberOfMatchesInString(string, options: NSMatchingOptions(rawValue: 0), range: fullRangeForString(string))

        return nbMatches > 0
    }

    /// returns the matching part of a String
    public func match(string:String) -> String? {
        let allStringRange = fullRangeForString(string)

        if let res = regexp.firstMatchInString(string, options: NSMatchingOptions(rawValue: 0), range: allStringRange) {
            let stringAsNS = string as NSString
            let firstMatch = stringAsNS.substringWithRange(res.range)
            return firstMatch
        } else {
            return nil
        }
    }

    /// returns all matches (including capture groups) as an array of String
    public func allMatches(string:String) -> [String] {

        var matches = [String]()

        let stringAsNS = string as NSString

        regexp.enumerateMatchesInString(string, options: NSMatchingOptions(rawValue: 0), range: fullRangeForString(string)) {
            (textCheckingResult:NSTextCheckingResult?, flags:NSMatchingFlags, stop:UnsafeMutablePointer<ObjCBool>) -> Void in

            if let textCheckingResult = textCheckingResult {
                for i in 0..<textCheckingResult.numberOfRanges {

                    let subMatch = stringAsNS.substringWithRange(textCheckingResult.rangeAtIndex(i))
                    matches.append(subMatch as String)
                }
            }
        }

        return matches
    }

    private func fullRangeForString(string:String) -> NSRange {
        return NSRange(location:0, length:string.characters.count)
    }
}

/// Some operator overloading
infix operator =~ {}

public func =~ (left:String, right:RegExp) -> String? {
    return right.match(left)
}

public func =~ (left:RegExp, right:String) -> String? {
    return left.match(right)
}


