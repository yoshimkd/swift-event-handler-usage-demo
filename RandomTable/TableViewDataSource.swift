//
//  TableViewDataSource.swift
//  RandomTable
//
//  Created by Jovan Jovanovski on 12/12/18.
//  Copyright © 2018 Jovan Jovanovski. All rights reserved.
//

import UIKit

final class TableViewDataSource: NSObject, UITableViewDataSource {
  
  private let tableCellIdentifier = "TableCell"
  var texts: [String] = []
  
  func tableView(
    _ tableView: UITableView,
    numberOfRowsInSection section: Int) -> Int {
    return texts.count
  }
  
  func tableView(
    _ tableView: UITableView,
    cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(
      withIdentifier: tableCellIdentifier, for: indexPath)
    let text = texts[indexPath.row]
    cell.textLabel!.text = text
    return cell
  }
  
}
