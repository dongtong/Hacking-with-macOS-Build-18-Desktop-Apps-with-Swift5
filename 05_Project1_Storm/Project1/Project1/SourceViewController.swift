//
//  SourceViewController.swift
//  Project1
//
//  Created by Hiroki Ikeuchi on 2019/12/29.
//  Copyright © 2019 ikeh1024. All rights reserved.
//

import Cocoa

class SourceViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {

  @IBOutlet var tableView: NSTableView!
  
  override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
  }
  
  func numberOfRows(in tableView: NSTableView) -> Int {
    return 100
  }
  
  func tableView(_ tableView: NSTableView,
                 viewFor tableColumn: NSTableColumn?,
                 row: Int) -> NSView? {
    guard let vw = tableView.makeView(withIdentifier: tableColumn!.identifier, owner: self) as? NSTableCellView else {
      return nil
    }
    vw.textField?.stringValue = "Hello, world!"
    
    return vw
  }
}

