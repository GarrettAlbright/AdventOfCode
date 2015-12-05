//
//  main.swift
//  
//
//  Created by Garrett Albright on 12/5/15.
//
//

import Foundation

let input: String
let newlineChar: Character = "\n"
var wrappingPaperNeeded: Int = 0
var ribbonNeeded: Int = 0

do {
    input = try String(contentsOfFile: "input.txt", encoding: NSASCIIStringEncoding)
}
catch {
    print("Coudn't open input file.")
    exit(1)
}

let presents: [String] = input.characters.split{$0 == newlineChar}.map(String.init)

for present: String in presents {
    let dimensions: [Int] = present.characters.split{$0 == "x"}.map{Int.init(String.init($0), radix: 10)!}
    let smallestDimensions: ArraySlice<Int> = dimensions.sort()[0...1]
    // Unnecessarily split calculations across multiple lines to avoid
    // "expression was too complex to be solved in reasonable time"
    wrappingPaperNeeded += (2 * dimensions[0] * dimensions[1])
        + (2 * dimensions[1] * dimensions[2])
        + (2 * dimensions[0] * dimensions[2]);
    wrappingPaperNeeded += smallestDimensions[0] * smallestDimensions[1]
    ribbonNeeded += (2 * smallestDimensions[0]) + (2 * smallestDimensions[1]);
    ribbonNeeded += dimensions[0] * dimensions[1] * dimensions[2];
}

print("We need \(wrappingPaperNeeded) square feet of paper.")
print("We need \(ribbonNeeded) feet of ribbon.")