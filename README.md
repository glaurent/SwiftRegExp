# What is this

SwiftyRegExp is a simple and convenient Swift wrapper around NSRegularExpression. It was inspired by [Ben Scheirman's "RegEx in Swift" post](http://benscheirman.com/2014/06/regex-in-swift/
)

<<<<<<< HEAD
Swift 2 version is in the 'swift2' branch, which will eventually be merged on to master.
=======
# Install using Cocoapods

    use_frameworks!

    pod "SwiftRegExp", "~> 1.0"

Then import it where you want it:

    import SwiftRegExp
>>>>>>> swift2

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