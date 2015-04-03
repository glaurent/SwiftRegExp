# What is this

SwiftyRegExp is a simple and convenient Swift wrapper around NSRegularExpression. It was inspired by [Ben Scheirman's "RegEx in Swift" post](http://benscheirman.com/2014/06/regex-in-swift/
)

# Examples

## Simple boolean match


    if let regexp = RegExp("abc.*") {
        if regexp.isMatching("abcdef") {
           println("match!")
        } else {
           println("error")
        }
    }


## Get matched string

    if let regexp = RegExp("abc.*") {
        if let match = "abcdef" =~ regexp {
           println("match : \(match)!")
        } else {
           println("error")
        }
    }

## Get all matches

Also works with capture groups :

    if let regexp = RegExp("abc(.*)def(.*)") {
        let matches = regexp.allMatches("abcXXXdefYYYY")
        for match in matches {
            println("match \(match)")
        }
    }
    
this will print "abcXXXdefYYYY", "XXX", "YYYY"



# How to use

Simply drop the `RegExp.swift` file in your project