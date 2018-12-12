//
//  RandomTableState.swift
//  RandomTable
//
//  Created by Jovan Jovanovski on 12/12/18.
//  Copyright © 2018 Jovan Jovanovski. All rights reserved.
//

import protocol SwiftEventHandler.State

struct RandomTableState: SwiftEventHandler.State {
  
  var textsCount: Int
  var randomIntForUpperLimitProvider: (Int) -> Int
  var nextNumber: Int
  
  init(textsCount: Int = 0,
       randomIntForUpperLimitProvider: @escaping (Int) -> Int =
    { Int.random(in: 0 ... $0) },
       nextNumber: Int = 0) {
    self.textsCount = textsCount
    self.randomIntForUpperLimitProvider = randomIntForUpperLimitProvider
    self.nextNumber = nextNumber
  }
  
}
