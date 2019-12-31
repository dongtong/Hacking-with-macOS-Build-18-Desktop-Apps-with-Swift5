//
//  ViewController.swift
//  Project4_01
//
//  Created by Hiroki Ikeuchi on 2019/12/31.
//  Copyright © 2019 ikeh1024. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func urlEntered(_ sender: NSTextField) {
        print("urlEntered")
    }
    
    @IBAction func navigationClicked(_ sender: NSSegmentedControl) {
         print("navigationClicked")
    }
    
    @IBAction func adjustRows(_ sender: NSSegmentedControl) {
         print("adjustRows")
    }
    
    @IBAction func adjustColumns(_ sender: NSSegmentedControl) {
         print("adjustColumns")
    }

}

