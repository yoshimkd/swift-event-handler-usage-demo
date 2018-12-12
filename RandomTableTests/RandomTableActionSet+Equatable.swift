//
//  RandomTableActionSet+Equatable.swift
//  RandomTableTests
//
//  Created by Jovan Jovanovski on 12/12/18.
//  Copyright © 2018 Jovan Jovanovski. All rights reserved.
//

@testable import RandomTable

extension RandomTableActionSet: Equatable {
  
  public static func ==(
    lhs: RandomTableActionSet, rhs: RandomTableActionSet) -> Bool {
    switch (lhs, rhs) {
    case
    (.addText(let lhsIndex, let lhsText), .addText(let rhsIndex, let rhsText)):
      return lhsIndex == rhsIndex && lhsText == rhsText
    case (.removeTextAtIndex(let lhsIndex), .removeTextAtIndex(let rhsIndex)):
      return lhsIndex == rhsIndex
    default:
      return false
    }
  }
  
}
