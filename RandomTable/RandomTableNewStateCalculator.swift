//
//  RandomTableNewStateCalculator.swift
//  RandomTable
//
//  Created by Jovan Jovanovski on 12/12/18.
//  Copyright © 2018 Jovan Jovanovski. All rights reserved.
//

func randomTableNewStateCalculator(
  oldState: RandomTableState,
  actionSet: RandomTableActionSet) -> RandomTableState {
  var newState = oldState
  
  switch actionSet {
  case .addText:
    newState.textsCount += 1
    newState.nextNumber += 1
  case .removeTextAtIndex:
    newState.textsCount -= 1
  }
  
  return newState
}
