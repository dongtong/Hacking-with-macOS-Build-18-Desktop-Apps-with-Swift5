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

//        createVFL()
//        createAnchors()
        createStackView()
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
    
    func createAnchors() {
        // create a variable to track the previous view we placed
        var previous: NSView!
        
        // craete four views and put them into an array
        let views = [makeView(0), makeView(1), makeView(2), makeView(3)]
        
        for vw in views {
            // add this child to our main view, making it fill the horizontal space and be 88 points high
            view.addSubview(vw)
            vw.widthAnchor.constraint(equalToConstant: 88).isActive = true
            vw.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            
            if previous != nil {
                // we have a previous view, position us 10 points vertically away from it
                vw.topAnchor.constraint(equalTo: previous.bottomAnchor, constant: 10).isActive = true
            } else {
                // we don't have a previous view, position us against the top edge
                vw.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            }
            
            // set the previous view to be the current one, for the next loop iteration
            previous = vw
        }
        
        // make the final view sit against the bottom edge of our main view
        previous.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func createStackView() {
        // create a stack view from four textFields
        let stackView = NSStackView(views: [makeView(0), makeView(1), makeView(2), makeView(3)])
        
        // make them take up an equal amount of space
        stackView.distribution = .fillEqually
        
        // make the views line up vertically
        stackView.orientation = .vertical
        
        // set this to false so we can create our own Auto Layout constraints
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        // NSTextFieldを幅いっぱいに広げる
        for view in stackView.arrangedSubviews {
            view.setContentHuggingPriority(NSLayoutConstraint.Priority(1), for: .horizontal)
            view.setContentHuggingPriority(NSLayoutConstraint.Priority(1), for: .vertical)
        }
        
        // make the stack view sit directly against all four edges
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

