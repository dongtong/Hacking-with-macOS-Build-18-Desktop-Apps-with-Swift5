//
//  WindowController.swift
//  Project4
//
//  Created by Hiroki Ikeuchi on 2019/12/29.
//  Copyright © 2019 ikeh1024. All rights reserved.
//

import Cocoa

class WindowController: NSWindowController {

    @IBOutlet var addressEntry: NSTextField!
    
    override func windowDidLoad() {
        super.windowDidLoad()
    
        window?.titleVisibility = .hidden
    }

    override func cancelOperation(_ sender: Any?) {
        
        window?.makeFirstResponder(self.contentViewController)
    }
    
}
