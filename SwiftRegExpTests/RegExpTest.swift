//
//  RegExpTest.swift
//  SwiftRegExp
//
//  Created by Guillaume Laurent on 02/04/15.
//  Copyright (c) 2015 Guillaume Laurent. All rights reserved.
//

import Foundation
import XCTest


class RegExpTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testIsMatching() {
        let regexp = RegExp(pattern:"abc", options:NSRegularExpressionOptions.CaseInsensitive)

        XCTAssert(regexp != nil, "RegExp creation passed")

        let isMatching = regexp!.isMatching("foo abc bar")

        XCTAssert(isMatching, "Match test fail")
    }

    func testCreationFail() {

        let regexp = RegExp(pattern:"abc(", options:NSRegularExpressionOptions.CaseInsensitive)

        XCTAssert(regexp == nil, "RegExp creation error test failed")

    }

    func testMatches() {
        let regexp = RegExp(pattern:"abc(.*)def(.*)", options:NSRegularExpressionOptions.CaseInsensitive)

        let string = "abcXXXdefYYY"
        let matches = regexp!.allMatches(string)

        XCTAssert(matches.count == 3, "number of matches test fail")
        XCTAssert(matches[0] == string, "Wrong 1st match")
        XCTAssert(matches[1] == "XXX", "Wrong 2nd match")
        XCTAssert(matches[2] == "YYY", "Wrong 3rd match")
    }

    func testMatch() {
        let regexp = RegExp(pattern:"ab.", options:NSRegularExpressionOptions.CaseInsensitive)

        let match = regexp?.match("abcdef")

        XCTAssert(match != nil, "No match found")
        XCTAssert(match == "abc", "Wrong match")
    }

    func testOperator1() {

        let regexp = RegExp(pattern:"ab.", options:NSRegularExpressionOptions.CaseInsensitive)

        let match = regexp! =~ "abcdef"

    }


    func testOperator2() {

        let regexp = RegExp(pattern:"ab.", options:NSRegularExpressionOptions.CaseInsensitive)

        let match = "abcdef" =~ regexp!        
    }


}
