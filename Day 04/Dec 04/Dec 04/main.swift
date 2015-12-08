//
//  main.swift
//  Dec 04
//
//  Created by Garrett Albright on 12/7/15.
//  Copyright © 2015 Garrett Albright. All rights reserved.
//

import Foundation

// http://iosdeveloperzone.com/2014/10/03/using-commoncrypto-in-swift/

if Process.arguments.count != 2 {
    print("Give a single input.")
    exit(1)
}

var s: String = Process.arguments[1]
var suffix: UInt = 0
var hashed: String

repeat {
    suffix++
    if suffix % 100000 == 0{
        print (suffix)
    }
    let toHash: String = s + String(suffix)
    var context = UnsafeMutablePointer<CC_MD5_CTX>.alloc(1)
    var digest = Array<UInt8>(count:Int(CC_MD5_DIGEST_LENGTH), repeatedValue:0)
    CC_MD5_Init(context)
    CC_MD5_Update(context, toHash,
        CC_LONG(toHash.lengthOfBytesUsingEncoding(NSUTF8StringEncoding)))
    CC_MD5_Final(&digest, context)
    context.dealloc(1)
    hashed = ""
    for byte in digest {
        hashed += String(format:"%02x", byte)
    }
    
    if hashed.substringToIndex(hashed.startIndex.advancedBy(6)) == "000000" {
        print("Suffix value \(suffix) resulted in hash \(hashed) (6 zeroes)")
        exit(0)
    }

    if hashed.substringToIndex(hashed.startIndex.advancedBy(5)) == "00000" {
        print("Suffix value \(suffix) resulted in hash \(hashed) (5 zeroes)")
    }

} while suffix < UInt.max

if (suffix == UInt.max) {
    print("Hit UInt.max before finding a solution.")
    exit(2)
}


