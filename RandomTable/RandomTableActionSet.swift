//
//  RandomTableActionSet.swift
//  RandomTable
//
//  Created by Jovan Jovanovski on 12/12/18.
//  Copyright © 2018 Jovan Jovanovski. All rights reserved.
//

import protocol SwiftEventHandler.ActionSet

enum RandomTableActionSet: SwiftEventHandler.ActionSet {
  
  case addText(index: Int, text: String)
  case removeTextAtIndex(Int)
  
}
