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
        do {
            let regexp = try RegExp(pattern:"abc", options:RegularExpression.Options.caseInsensitive)

            let isMatching = regexp.isMatching("foo abc bar")

            XCTAssert(isMatching, "Match test fail")

        } catch {
            XCTFail("Match test init fail")
        }
    }

    func testCreationFail() {

        do {
            let _ = try RegExp(pattern:"abc(", options:RegularExpression.Options.caseInsensitive) // should throw

            XCTFail("RegExp creation test init fail")

        } catch {
            XCTAssert(true)
        }

    }

    func testMatches() {
        do {
            let regexp = try RegExp(pattern:"abc(.*)def(.*)", options:RegularExpression.Options.caseInsensitive)

            let string = "abcXXXdefYYY"
            let matches = regexp.allMatches(string)

            XCTAssert(matches.count == 3, "number of matches test fail")
            XCTAssert(matches[0] == string, "Wrong 1st match")
            XCTAssert(matches[1] == "XXX", "Wrong 2nd match")
            XCTAssert(matches[2] == "YYY", "Wrong 3rd match")
        } catch {
            XCTFail("RegExp matches test init fail")
        }
    }

    func testMatch() {
        do {
            let regexp = try RegExp(pattern:"ab.", options:RegularExpression.Options.caseInsensitive)

            let match = regexp.match("abcdef")

            XCTAssert(match != nil, "No match found")
            XCTAssert(match == "abc", "Wrong match")
        } catch {
            XCTFail("RegExp match test init fail")
        }
    }

    func testOperator1() {

        do {
            let regexp = try RegExp(pattern:"ab.", options:RegularExpression.Options.caseInsensitive)

            let match = regexp =~ "abcdef"

            XCTAssert(match == "abc", "Wrong match")

        } catch {
            XCTFail("RegExp creation test init fail")
        }
    }


    func testOperator2() {

        do {
            let regexp = try RegExp(pattern:"ab.", options:RegularExpression.Options.caseInsensitive)

            let match = "abcdef" =~ regexp

            XCTAssert(match == "abc", "Wrong match")

        } catch {
            XCTFail("RegExp creation test init fail")
        }
    }


}
