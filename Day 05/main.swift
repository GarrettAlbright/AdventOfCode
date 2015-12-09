//
//  main.swift
//  
//
//  Created by Garrett Albright on 12/8/15.
//
//

import Foundation

func checkNicetyOldRules(string: String) -> Bool {
    let vowelPattern: NSRegularExpression
    let doubleLetterPattern: NSRegularExpression
    let badPairPattern: NSRegularExpression
    do {
        vowelPattern = try NSRegularExpression.init(pattern: "[aeiou]", options: [])
        doubleLetterPattern = try NSRegularExpression.init(pattern: "(.)(\\1+)", options: [])
        badPairPattern = try NSRegularExpression.init(pattern: "(ab|cd|pq|xy)", options: [])
    }
    catch _ {
        print("Huh. That's suprising.")
        exit(255)
    }
    
    let stringRange: NSRange = NSRange(location: 0, length: string.characters.count)
    
    if vowelPattern.numberOfMatchesInString(string, options: [], range: stringRange) < 3 {
        print("\(string) is naughty - not enough vowels")
        return false
    }
    
    if doubleLetterPattern.firstMatchInString(string, options: [], range: stringRange) == nil {
        print("\(string) is naughty - no double letters")
        return false
    }
    
    if badPairPattern.firstMatchInString(string, options: [], range: stringRange) != nil {
        print("\(string) is naughty - has a bad pair")
        return false
    }
    
    return true
}

func checkNicetyNewRules(string: String) -> Bool {
    let doublePairPattern: NSRegularExpression
    let abaPattern: NSRegularExpression
    do {
        doublePairPattern = try NSRegularExpression.init(pattern: "(..).*(\\1)", options: [])
        abaPattern = try NSRegularExpression.init(pattern: "(.).(\\1)", options: [])
    }
    catch _ {
        print("Whoops.")
        exit(255)
    }

    let stringRange: NSRange = NSRange(location: 0, length: string.characters.count)

    if doublePairPattern.firstMatchInString(string, options: [], range: stringRange) == nil {
        print("\(string) is naughty - no double pairs")
        return false
    }
    
    if abaPattern.firstMatchInString(string, options: [], range: stringRange) == nil {
        print("\(string) is naughty - no aba match")
        return false
    }

    return true
        
}

let input: String

do {
    input = try String(contentsOfFile: "input.txt", encoding: NSASCIIStringEncoding)
}
catch {
    print("Coudn't open input file.")
    exit(1)
}

let strings: [String] = input.characters.split{$0 == Character("\n")}.map(String.init)
//let strings: [String] = ["ugknbfddgicrmopn", "aaa", "jchzalrnumimnmhp", "haegwjzuvuyypxyu", "dvszwmarrgswjxmb"]
//let strings: [String] = ["qjhvhtzxzqqjkmpb", "xxyxx", "uurcxstgmygtbstg", "ieodomkazucvgmuy"]
var niceCount: Int = 0
var niceCountNew: Int = 0

for string: String in strings {
    if checkNicetyOldRules(string) {
        niceCount++
    }
    if checkNicetyNewRules(string) {
        niceCountNew++
    }
}

print("\(niceCount) strings are nice by the old rules.")
print("\(niceCountNew) strings are nice by the new rules.")
