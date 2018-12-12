//
//  RandomTableEvent.swift
//  RandomTable
//
//  Created by Jovan Jovanovski on 12/12/18.
//  Copyright © 2018 Jovan Jovanovski. All rights reserved.
//

import protocol SwiftEventHandler.Event

enum RandomTableEvent: SwiftEventHandler.Event {
  
  case addRequested
  case removeRequested
  
}

extension RandomTableEvent: CustomDebugStringConvertible {
  
  var debugDescription: String {
    switch self {
    case .addRequested:
      return "add requested"
    case .removeRequested:
      return "remove requested"
    }
  }
  
}
