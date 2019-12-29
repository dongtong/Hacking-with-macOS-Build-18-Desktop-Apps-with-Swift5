//
//  ViewController.swift
//  Project2
//
//  Created by Hiroki Ikeuchi on 2019/12/29.
//  Copyright © 2019 ikeh1024. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {

    var answer = ""
    var guesses = [String]()
    
    @IBOutlet var tableView: NSTableView!
    @IBOutlet var guess: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    func numberOfRows(in tableView: NSTableView) -> Int {
        return guesses.count
    }
    
    @IBAction func submitGuess(_ sender: Any) {
        
    }
    
    func result(for guess: String) -> String {
        
        return "Result" // e.g. 1c1b
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        guard let vw = tableView.makeView(withIdentifier: tableColumn!.identifier, owner: self) as? NSTableCellView else { return nil }
        
        if tableColumn?.title == "Guess" {
            
            // this is the "Guess" column; show a previous guess
            vw.textField?.stringValue = result(for: guesses[row])
        }
        
        return vw
    }
    
    func tableView(_ tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
        
        return false
    }

}

