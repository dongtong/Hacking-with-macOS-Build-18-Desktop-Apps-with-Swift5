//
//  ViewController.swift
//  Project8
//
//  Created by Hiroki Ikeuchi on 2020/01/09.
//  Copyright © 2020 ikeh1024. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    var visualEffectView: NSVisualEffectView!
    var gridViewButtons = [NSButton]()
    let gridSize = 10
    let gridMargin: CGFloat = 5

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    override func loadView() {
        super.loadView()
        
        visualEffectView = NSVisualEffectView()
        visualEffectView.translatesAutoresizingMaskIntoConstraints = false
        
        // enable the dark vibrancy effect
        visualEffectView.material = .dark
        
        // force it to remain active even when the window loses focus
        visualEffectView.state = .active
        view.addSubview(visualEffectView)
        
        // pin it ot the edge of our window
        visualEffectView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        visualEffectView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        visualEffectView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        visualEffectView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        let title = createTitle()
        createGridView(relativeTo: title)
    }
    
    func createTitle() -> NSTextField {
        let titleString = "Odd OneOut"
        let title = NSTextField(labelWithString: titleString)
        title.font = NSFont.systemFont(ofSize: 36, weight: .thin)
        title.textColor = NSColor.white
        title.translatesAutoresizingMaskIntoConstraints = false
        
        visualEffectView.addSubview(title)
        title.topAnchor.constraint(equalTo: visualEffectView.topAnchor,
                                   constant: gridMargin).isActive = true
        title.centerXAnchor.constraint(equalTo: visualEffectView.centerXAnchor).isActive = true
        
        return title
    }
    
    func createButtonArray() -> [[NSButton]] {
        var rows = [[NSButton]]()
        
        for _ in 0 ..< gridSize {
            var row = [NSButton]()
            for _ in 0 ..< gridSize {
                let button = NSButton(frame: NSRect(x: 0, y: 0, width: 64, height: 64))
                
                button.image = NSImage(named: "penguin")
                button.setButtonType(.momentaryChange)
                button.imagePosition = .imageOnly
                button.focusRingType = .none
                button.isBordered = false
                // button.action = #selector(iamgeClicked)
                
                gridViewButtons.append(button)
                row.append(button)
            }
            rows.append(row)
        }
        return rows
    }
    
    func createGridView(relativeTo title: NSTextField) {
        let rows = createButtonArray()
        let gridView = NSGridView(views: rows)
        
        gridView.translatesAutoresizingMaskIntoConstraints = false
        visualEffectView.addSubview(gridView)
        
        gridView.leadingAnchor.constraint(equalTo: visualEffectView.leadingAnchor, constant: gridMargin).isActive = true
        gridView.trailingAnchor.constraint(equalTo: visualEffectView.trailingAnchor, constant: -gridMargin).isActive = true
        gridView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: gridMargin).isActive = true
        gridView.bottomAnchor.constraint(equalTo: visualEffectView.bottomAnchor, constant: -gridMargin).isActive = true
        
        gridView.columnSpacing = gridMargin / 2
        gridView.rowSpacing = gridMargin / 2
        
        for i in 0 ..< gridSize {
            gridView.row(at: i).height = 64
            gridView.column(at: i).width = 64
        }
    }
}

