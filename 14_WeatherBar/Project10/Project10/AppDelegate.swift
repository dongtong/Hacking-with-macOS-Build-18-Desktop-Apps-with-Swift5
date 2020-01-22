//
//  AppDelegate.swift
//  Project10
//
//  Created by Hiroki Ikeuchi on 2020/01/22.
//  Copyright © 2020 ikeh1024. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {


    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        statusItem.button?.title = "Fetching..."
        statusItem.menu = NSMenu()
        addConfigurationMenuItem()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func addConfigurationMenuItem() {
        let separator = NSMenuItem(title: "Settings",
                                   action: #selector(showSettings(_:)),
                                   keyEquivalent: "")
        statusItem.menu?.addItem(separator)
    }
    
    @objc func showSettings(_ sender: NSMenuItem) {
        
    }
    
}

