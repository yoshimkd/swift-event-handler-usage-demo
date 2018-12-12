//
//  RandomTableNewStateCalculatorTests.swift
//  RandomTableTests
//
//  Created by Jovan Jovanovski on 12/12/18.
//  Copyright © 2018 Jovan Jovanovski. All rights reserved.
//

import XCTest
@testable import RandomTable

final class RandomTableNewStateCalculatorTests: XCTestCase {
  
  func test1() {
    let oldTextCount = 0
    let oldNextNumber = 0
    let oldState = RandomTableState(
      textsCount: oldTextCount, nextNumber: oldNextNumber)
    let actionSet = RandomTableActionSet.addText(index: Int.max, text: "")
    let newState = randomTableNewStateCalculator(
      oldState: oldState, actionSet: actionSet)
    XCTAssertEqual(oldTextCount + 1, newState.textsCount)
    XCTAssertEqual(oldNextNumber + 1, newState.nextNumber)
  }
  
  func test2() {
    let oldTextCount = 1
    let oldNextNumber = 0
    let oldState = RandomTableState(
      textsCount: oldTextCount, nextNumber: oldNextNumber)
    let actionSet = RandomTableActionSet.removeTextAtIndex(Int.max)
    let newState = randomTableNewStateCalculator(
      oldState: oldState, actionSet: actionSet)
    XCTAssertEqual(oldTextCount - 1, newState.textsCount)
    XCTAssertEqual(oldNextNumber, newState.nextNumber)
  }
  
}
