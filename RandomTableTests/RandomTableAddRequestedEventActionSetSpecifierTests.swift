//
//  RandomTableAddRequestedEventActionSetSpecifierTests.swift
//  RandomTableTests
//
//  Created by Jovan Jovanovski on 12/12/18.
//  Copyright © 2018 Jovan Jovanovski. All rights reserved.
//

import XCTest
@testable import RandomTable

final class RandomTableAddRequestedEventActionSetSpecifierTests: XCTestCase {
  
  //MARK: - Tests verifying that the other events are not being handled
  
  func testNotHandlingRemoveRequested() {
    let oldState = RandomTableState()
    let event = RandomTableEvent.removeRequested
    do {
      let actionSets = try randomTableAddRequestedEventActionSetSpecifier(
        oldState: oldState,
        event: event)
      XCTAssert(actionSets.isEmpty)
    } catch {
      XCTFail()
    }
  }
  
  //MARK: - Tests verifying that an error is thrown when
  //the old state and event pair is invalid
  
  func testErrorThrownWhenStateTextsCountLessThanZero() {
    let oldState = RandomTableState(textsCount: -1)
    let event = RandomTableEvent.addRequested
    XCTAssertThrowsError(try randomTableAddRequestedEventActionSetSpecifier(
      oldState: oldState,
      event: event)
    )
  }
  
  //MARK: - Tests verifying the normal execution
  
  func testNormalExecution1() {
    let nextNumber = 10
    let oldState = RandomTableState(textsCount: 0, nextNumber: nextNumber)
    let event = RandomTableEvent.addRequested
    do {
      let actionSets = try randomTableAddRequestedEventActionSetSpecifier(
        oldState: oldState,
        event: event)
      XCTAssertEqual(1, actionSets.count)
      XCTAssertEqual(
        .addText(index: 0, text: "\(nextNumber)"), actionSets.first!)
    } catch {
      XCTFail()
    }
  }
  
  func testNormalExecution2() {
    let textsCount = 10
    let nextNumber = 10
    let randomInt = 5
    let oldState = RandomTableState(
      textsCount: textsCount,
      randomIntForUpperLimitProvider: { _ in return randomInt },
      nextNumber: nextNumber)
    let event = RandomTableEvent.addRequested
    do {
      let actionSets = try randomTableAddRequestedEventActionSetSpecifier(
        oldState: oldState,
        event: event)
      XCTAssertEqual(1, actionSets.count)
      XCTAssertEqual(
        .addText(index: randomInt, text: "\(nextNumber)"), actionSets.first!)
    } catch {
      XCTFail()
    }
  }
  
}
