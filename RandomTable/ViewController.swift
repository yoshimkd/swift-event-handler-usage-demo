//
//  ViewController.swift
//  RandomTable
//
//  Created by Jovan Jovanovski on 12/12/18.
//  Copyright © 2018 Jovan Jovanovski. All rights reserved.
//

import UIKit
import SwiftEventHandler

final class ViewController: UIViewController {
  
  @IBOutlet private weak var tableView: UITableView!
  private let tableViewDataSource = TableViewDataSource()
  private var eventHandler:
  EventHandler<RandomTableState, RandomTableEvent, RandomTableActionSet>!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.dataSource = tableViewDataSource
    
    eventHandler = .init(
      initialState: .init(),
      actionSetsSpecifiers:
      [randomTableAddRequestedEventActionSetSpecifier,
       randomTableRemoveRequestedEventActionSetSpecifier],
      reactor: reactor,
      newStateCalculator: randomTableNewStateCalculator)
  }
  
  private func reactor(actionSet: RandomTableActionSet) {
    let mainThreadBlock = {
      switch actionSet {
      case .addText(let index, let text):
        self.tableViewDataSource.texts.insert(text, at: index)
        self.tableView.insertRows(
          at: [.init(row: index, section: 0)],
          with: .automatic)
      case .removeTextAtIndex(let index):
        self.tableViewDataSource.texts.remove(at: index)
        self.tableView.deleteRows(
          at: [.init(row: index, section: 0)],
          with: .automatic)
      }
    }
    
    if Thread.isMainThread {
      mainThreadBlock()
    } else {
      DispatchQueue.main.sync(execute: mainThreadBlock)
    }
  }
  
  @IBAction private func addButtonTapHandler() {
    eventHandler.eventReceiver(event: .addRequested)
  }
  
  @IBAction private func removeButtonTapHandler() {
    eventHandler.eventReceiver(event: .removeRequested)
  }
  
}
