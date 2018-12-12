//
//  RandomTableRemoveRequestedEventActionSetSpecifierTests.swift
//  RandomTableTests
//
//  Created by Jovan Jovanovski on 12/12/18.
//  Copyright © 2018 Jovan Jovanovski. All rights reserved.
//

import XCTest
@testable import RandomTable

final class RandomTableRemoveRequestedEventActionSetSpecifierTests: XCTestCase {
  
  //MARK: - Tests verifying that the other events are not being handled
  
  func testNotHandlingAddRequested() {
    let oldState = RandomTableState()
    let event = RandomTableEvent.addRequested
    do {
      let actionSets = try randomTableRemoveRequestedEventActionSetSpecifier(
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
    let event = RandomTableEvent.removeRequested
    XCTAssertThrowsError(try randomTableRemoveRequestedEventActionSetSpecifier(
      oldState: oldState,
      event: event)
    )
  }
  
  //MARK: - Tests verifying the normal execution
  
  func testNormalExecution1() {
    let oldState = RandomTableState(textsCount: 0)
    let event = RandomTableEvent.removeRequested
    do {
      let actionSets = try randomTableRemoveRequestedEventActionSetSpecifier(
        oldState: oldState,
        event: event)
      XCTAssert(actionSets.isEmpty)
    } catch {
      XCTFail()
    }
  }
  
  func testNormalExecution2() {
    let oldState = RandomTableState(textsCount: 1)
    let event = RandomTableEvent.removeRequested
    do {
      let actionSets = try randomTableRemoveRequestedEventActionSetSpecifier(
        oldState: oldState,
        event: event)
      XCTAssertEqual(1, actionSets.count)
      XCTAssertEqual(.removeTextAtIndex(0), actionSets.first!)
    } catch {
      XCTFail()
    }
  }
  
  func testNormalExecution3() {
    let textsCount = 10
    let randomInt = 5
    let oldState = RandomTableState(
      textsCount: textsCount,
      randomIntForUpperLimitProvider: { _ in return randomInt })
    let event = RandomTableEvent.removeRequested
    do {
      let actionSets = try randomTableRemoveRequestedEventActionSetSpecifier(
        oldState: oldState,
        event: event)
      XCTAssertEqual(1, actionSets.count)
      XCTAssertEqual(.removeTextAtIndex(randomInt), actionSets.first!)
    } catch {
      XCTFail()
    }
  }
  
}
