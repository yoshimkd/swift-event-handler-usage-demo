//
//  RandomTableRemoveRequestedEventActionSetSpecifier.swift
//  RandomTable
//
//  Created by Jovan Jovanovski on 12/12/18.
//  Copyright © 2018 Jovan Jovanovski. All rights reserved.
//

import struct SwiftEventHandler.InvalidOldStateAndEventPairError

func randomTableRemoveRequestedEventActionSetSpecifier(
  oldState: RandomTableState,
  event: RandomTableEvent) throws -> [RandomTableActionSet] {
  guard case .removeRequested = event else { return [] }
  if oldState.textsCount < 0 { throw InvalidOldStateAndEventPairError() }
  
  if oldState.textsCount == 0 { return [] }
  let index = oldState.randomIntForUpperLimitProvider(oldState.textsCount - 1)

  return [.removeTextAtIndex(index)]
}
