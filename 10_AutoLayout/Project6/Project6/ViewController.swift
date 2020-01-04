//
//  ViewController.swift
//  Project6
//
//  Created by Hiroki Ikeuchi on 2020/01/04.
//  Copyright © 2020 ikeh1024. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        createVFL()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    func makeView(_ number: Int) -> NSView {
        let vw = NSTextField(labelWithString: "View #\(number)")
        
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.alignment = .center
        vw.wantsLayer = true
        vw.layer?.backgroundColor = NSColor.cyan.cgColor
        
        return vw
    }
    
    func createVFL() {
        // set up a dictionary of strings and views
        let textFields = ["view0" : makeView(0),
                          "view1" : makeView(1),
                          "view2" : makeView(2),
                          "view3" : makeView(3)]
        
        // loop over each item
        for (name, textField) in textFields {
            // add it to our view
            view.addSubview(textField)
            
            // add horizontal constraints saying that this view should stretch from edge to edge
            view.addConstraints(NSLayoutConstraint.constraints(
                withVisualFormat: "H:|[\(name)]|",
                options: [],
                metrics: nil,
                views: textFields))
        }
        
        // add another set of constrains that cause the views to be aligned vertically, one above the other
        view.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|[view0]-[view1]-[view2]-[view3]|",
            options: [],
            metrics: nil,
            views: textFields))
    }
    
}

