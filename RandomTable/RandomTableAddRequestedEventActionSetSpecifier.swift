//
//  RandomTableAddRequestedEventActionSetSpecifier.swift
//  RandomTable
//
//  Created by Jovan Jovanovski on 12/12/18.
//  Copyright © 2018 Jovan Jovanovski. All rights reserved.
//

import struct SwiftEventHandler.InvalidOldStateAndEventPairError

func randomTableAddRequestedEventActionSetSpecifier(
  oldState: RandomTableState,
  event: RandomTableEvent) throws -> [RandomTableActionSet] {
  guard case .addRequested = event else { return [] }
  if oldState.textsCount < 0 { throw InvalidOldStateAndEventPairError() }
  
  let index = oldState.randomIntForUpperLimitProvider(oldState.textsCount)
  let text = "\(oldState.nextNumber)"
  
  return [.addText(index: index, text: text)]
}
