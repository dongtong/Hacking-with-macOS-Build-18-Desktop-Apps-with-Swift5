//
//  WindowController.swift
//  Project8
//
//  Created by Hiroki Ikeuchi on 2020/01/13.
//  Copyright © 2020 ikeh1024. All rights reserved.
//

import Cocoa

class WindowController: NSWindowController {

    override func windowDidLoad() {
        super.windowDidLoad()
    
        window?.styleMask = [window!.styleMask, .fullSizeContentView]
        window?.titlebarAppearsTransparent = true
        window?.titleVisibility = .hidden
        window?.isMovableByWindowBackground = true
    }

}
