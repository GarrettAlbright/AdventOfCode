//
//  main.swift
//  
//
//  Created by Garrett Albright on 12/5/15.
//
//

import Foundation

let input: String
var visitedCoords: Dictionary<Int, Dictionary<Int, Int>> = [0: [0: 1]]
var x: Int = 0
var y: Int = 0

enum Deliverer: Int {
    case Santa, RoboSanta
}
var roboSantasTurn: Bool = true
var santaVsRoboSantaVisitedCoords: Dictionary<Int, Dictionary<Int, Int>> = [0: [0: 1]]
var santaVsRoboSantaCoords: Dictionary<Deliverer, Dictionary<Character, Int>> = [.Santa: ["x": 0, "y": 0], .RoboSanta: ["x": 0, "y": 0]]


do {
    input = try String(contentsOfFile: "input.txt", encoding: NSASCIIStringEncoding)
}
catch {
    print("Coudn't open input file.")
    exit(1)
}

for direction: Character in input.characters {
    roboSantasTurn = !roboSantasTurn
    let deliverer: Deliverer = roboSantasTurn ? .RoboSanta : .Santa

    switch direction {
    case "<":
        x--
        santaVsRoboSantaCoords[deliverer]!["x"] = santaVsRoboSantaCoords[deliverer]!["x"]! - 1
    case ">":
        x++
        santaVsRoboSantaCoords[deliverer]!["x"] = santaVsRoboSantaCoords[deliverer]!["x"]! + 1
    case "^":
        y--
        santaVsRoboSantaCoords[deliverer]!["y"] = santaVsRoboSantaCoords[deliverer]!["y"]! - 1
    case "v":
        y++
        santaVsRoboSantaCoords[deliverer]!["y"] = santaVsRoboSantaCoords[deliverer]!["y"]! + 1
    default:
        print("Unexpected directional character \"\(direction)\"")
        exit(2)
    }

    if visitedCoords.indexForKey(x) == nil {
        visitedCoords[x] = [:]
    }

    if visitedCoords[x]!.indexForKey(y) == nil {
        visitedCoords[x]![y] = 1
    }
    else {
        visitedCoords[x]![y] = visitedCoords[x]![y]! + 1
    }

    let delivererX: Int = santaVsRoboSantaCoords[deliverer]!["x"]!
    let delivererY: Int = santaVsRoboSantaCoords[deliverer]!["y"]!

    if santaVsRoboSantaVisitedCoords.indexForKey(delivererX) == nil {
        santaVsRoboSantaVisitedCoords[delivererX] = [:]
    }
    if santaVsRoboSantaVisitedCoords[delivererX]!.indexForKey(delivererY) == nil {
        santaVsRoboSantaVisitedCoords[delivererX]![delivererY] = 1
    }
    else {
        santaVsRoboSantaVisitedCoords[delivererX]![delivererY] = santaVsRoboSantaVisitedCoords[delivererX]![delivererY]! + 1

    }
}

var houseCount = 0
for (_, yHouses) in visitedCoords {
    houseCount += yHouses.count
}

var nextYearHouseCount = 0
for (_, yHouses) in santaVsRoboSantaVisitedCoords {
    nextYearHouseCount += yHouses.count
}

print("Santa visited \(houseCount) houses.")
print("The next year, Santa and Robo-Santa visited \(nextYearHouseCount) houses.")
