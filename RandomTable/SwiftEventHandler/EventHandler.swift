//
//  EventHandler.swift
//  SwiftEventHandler
//
//  Created by Jovan Jovanovski on 12/10/18.
//  Copyright © 2018 Jovan Jovanovski. All rights reserved.
//

import class Dispatch.DispatchQueue

public final class EventHandler<
  StateType: State,
  EventType: Event,
  ActionSetType: ActionSet
> {
  
  //MARK: - Public typealiases
  
  public typealias ActionSetsSpecifier =
    (StateType, EventType) throws -> [ActionSetType]
  public typealias NewStateCalculator = (StateType, ActionSetType) -> StateType
  public typealias Reactor = (ActionSetType) -> Void
  
  //MARK: - Private properties
  
  private let eventsQueue = DispatchQueue(
    label: "com.jovanjovanovski.swiftEventHandler")
  
  private var state: StateType
  private let actionSetsSpecifiers: [ActionSetsSpecifier]
  private let reactor: Reactor
  private let newStateCalculator: NewStateCalculator
  
  private let failSilently: Bool
  private let printLogs: Bool
  
  //MARK: - Public methods
  
  public init(
    initialState: StateType,
    actionSetsSpecifiers: [ActionSetsSpecifier],
    reactor: @escaping Reactor,
    newStateCalculator: @escaping NewStateCalculator,
    failSilently: Bool = false,
    printLogs: Bool = true) {
    self.state = initialState
    self.actionSetsSpecifiers = actionSetsSpecifiers
    self.reactor = reactor
    self.newStateCalculator = newStateCalculator
    self.failSilently = failSilently
    self.printLogs = printLogs
  }
  
  public func eventReceiver(
    event: EventType, blockUntilCompletion: Bool = false) {
    log("⚡")
    log("⚡ The event \(event) is received by the event handler")
    log("⚡ Block until completion: \(blockUntilCompletion)")
    log("⚡")
    
    let block: () -> Void = {
      [weak self, actionSetsSpecifiers = actionSetsSpecifiers, event = event] in
      guard let `self` = self else { return }
      
      self.log("✋ Starting handling event: \(event)")
      let actionsSets = self.actionSets(
        actionSetsSpecifiers: actionSetsSpecifiers,
        oldState: self.state,
        event: event,
        failSilently: self.failSilently)
      self.execute(actionSets: actionsSets)
      self.log("✋ Finished handling event: \(event)")
    }
    
    if blockUntilCompletion {
      eventsQueue.sync(execute: block)
    } else {
      eventsQueue.async(execute: block)
    }
  }
  
  //MARK: - Private methods
  
  private func actionSets(
    actionSetsSpecifiers: [ActionSetsSpecifier],
    oldState: StateType,
    event: EventType,
    failSilently: Bool = false) -> [ActionSetType] {
    return actionSetsSpecifiers.flatMap {
      actionSetsSpecifier -> [ActionSetType] in
      do {
        return try actionSetsSpecifier(oldState, event)
      } catch {
        if failSilently {
          return []
        }
        preconditionFailure("Unexpected error occurred: \(error).")
      }
    }
  }
  
  private func execute(actionSets: [ActionSetType]) {
    if actionSets.isEmpty {
      log("⇒ No event action sets requested to be executed")
      return
    }
    log("⇒ Requested to execute: \(actionSets.count) action sets")
    
    actionSets.enumerated().forEach {
      [weak self] index, actionSet in
      guard let `self` = self else { return }
      log("⇒ Starting execution of action set with index: \(index)")
      log("⇒ Invoking reactor")
      reactor(actionSet)
      log("⇒ The reactor finished its execution")
      log("⇒ Starting calculation of the new state")
      let newState = newStateCalculator(self.state, actionSet)
      log("⇒ Finshed calculation of the new state")
      self.state = newState
      log("⇒ Finished executing action set with index: \(index)")
    }
  }
  
  private func log(_ string: String) {
    if printLogs {
      print(string)
    }
  }
  
}

//MARK: - Public auxiliary types

public protocol State {}
public protocol Event {}
public protocol ActionSet {}
public struct InvalidOldStateAndEventPairError: Error { public init() {} }
