//
//  main.swift
//  
//
//  Created by Garrett Albright on 12/5/15.
//
//

import Foundation

let input: String
var floor: Int = 0
var characterPosition: Int = 0
var enteredTheBasement: Int?

do {
    input = try String(contentsOfFile: "input.txt", encoding: NSASCIIStringEncoding)
}
catch {
    print("Coudn't open input file.")
    exit(1)
}

for character: Character in input.characters {
    // characterPosition is 1-based
    characterPosition++
    if character == "(" {
        floor++
    }
    else if character == ")" {
        floor--
    }
    else {
        print("Unexpected character \(character) in input.")
        exit(2)
    }
    if (floor == -1 && enteredTheBasement == nil) {
        enteredTheBasement = characterPosition
    }
//    print(floor)
}

if (enteredTheBasement == nil) {
    print("Santa didn't enter the basement?!")
    exit(3)
}
 
print("Santa is on floor \(floor)")
print("Santa entered the basement at step \(enteredTheBasement!)")
