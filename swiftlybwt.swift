//: Playground - noun: a place where people can play

import UIKit

func bwtBuildWithoutSlice(s: String) -> String {
    // good practice for new String and Substring API, however Swift Slice is probably more efficient
    // see https://developer.apple.com/documentation/swift/slice
    let n = s.count
    var bwtArray = [String]()
    // var bwtArray = [Substring]()
    // see below
    for i in 0...n {
        let idx = s.index(s.startIndex, offsetBy: i, limitedBy: s.endIndex) ?? s.endIndex
        let idxRange = s.index(s.endIndex, offsetBy: (i - n))..<s.endIndex
        var fwdSubString = s[..<idx]
        var endSubString = s[idxRange]
        endSubString.insert("$", at: endSubString.endIndex)
        fwdSubString.insert(contentsOf: endSubString, at: fwdSubString.startIndex)
        // optional, this frees memory and converts from Substring instance
        // otherwise comment out and uncomment Substring lines
        let bwtString = String(fwdSubString)
        // bwtArray.append(fwdSubString)
        bwtArray.append(bwtString)
    }
    let bwt = bwtArray.sorted()
        .map {s in return s[s.index(before:s.endIndex)]}
    return String(bwt)
}

func bwtRetrieve(s: String) -> String {
    let stringLength = s.count
    var bwtCharacterIdx = [Int]()
    let bwtStopCharacter = s.distance(from: s.startIndex, to: s.index(of: "$")!)
    let sortedArray: [(Character, Int)] = s.enumerated().map({($0.element, $0.offset)}).sorted(by: {$0.0 < $1.0})
    bwtCharacterIdx.append(bwtStopCharacter)
    for _ in 1..<stringLength {
        bwtCharacterIdx.append(sortedArray[bwtCharacterIdx.last!].1)
    }
    let bwtString = bwtCharacterIdx.map {String(sortedArray[$0].0)}.filter {$0 != "$"}.reduce("", {$0 + $1})
    return bwtString
}

let testString = "panamabananas"
let testBwt = bwtBuildWithoutSlice(s: testString)
print(testBwt) // prints "smnpbnnaaaaa$a"
let retrieveFromBwt = bwtRetrieve(s: testBwt)
print(retrieveFromBwt) // prints "panamabananas"

