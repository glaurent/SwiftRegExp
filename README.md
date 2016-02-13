# What is this

SwiftyRegExp is a simple and convenient Swift wrapper around NSRegularExpression. It was inspired by [Ben Scheirman's "RegEx in Swift" post](http://benscheirman.com/2014/06/regex-in-swift/
)

**NOTE** : a better framework with more features can be found at [https://github.com/sharplet/Regex](https://github.com/sharplet/Regex)

# Install using CocoaPods

    use_frameworks!

    pod "SwiftRegExp", "~> 1.4"

Then import it where you want it:

    import SwiftRegExp

# Examples

## Simple boolean match


    let regexp = try RegExp("abc.*")
    if regexp.isMatching("abcdef") {
      println("match!")
    } else {
      println("error")
    }


## Get matched string

    let regexp = try RegExp("abc.*")
    if let match = "abcdef" =~ regexp {
       println("match : \(match)!")
    } else {
       println("error")
    }

## Get all matches

Also works with capture groups :

    let regexp = try RegExp("abc(.*)def(.*)")
    let matches = regexp.allMatches("abcXXXdefYYYY")
    for match in matches {
        println("match \(match)")
    }
    
this will print "abcXXXdefYYYY", "XXX", "YYYY"



# How to use

Simply drop the `RegExp.swift` file in your project