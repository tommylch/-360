//
//  Fisher-Yates.swift
//  TrueFalseStarter
//
//  Created by Leanne Thng on 7/2/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import Foundation

//
////Using the Fisher-Yates method for sorting in place
extension Collection {
// Return a copy of `self` with its elements shuffled
  func shuffle() -> [Generator.Element] {
   var list = Array(self)
    list.shuffleInPlace()
    return list
  }
}

extension MutableCollection where Index == Int {
//Shuffle the elements of `self` in-place.
  mutating func shuffleInPlace() {
     //empty and single-element collections don't shuffle
   if count < 2 { return }

    for i in startIndex ..< endIndex - 1 {
      let j = Int(arc4random_uniform(UInt32(endIndex - i))) + i
      guard i != j else { continue }
      swap(&self[i], &self[j])
    }
  }
}
/*
extension MutableCollection where Index == Int {
    /// Shuffle the elements of `self` in-place.
    mutating func shuffleInPlace() {
        // empty and single-element collections don't shuffle
        if count < 2 { return }
        
        for i in startIndex ..< endIndex - 1 {
           
            let j = Int(arc4random_uniform(UInt32(count))) + i
            guard i != j else { continue }
            swap(&self[i], &self[j])
        }
    }
}

extension Collection {
    /// Return a copy of `self` with its elements shuffled.
    func shuffle() -> [Generator.Element] {
        var list = Array(self)
        list.shuffleInPlace()
        return list
    }
}
 */
