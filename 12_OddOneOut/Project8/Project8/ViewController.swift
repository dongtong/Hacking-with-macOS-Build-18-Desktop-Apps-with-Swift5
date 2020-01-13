//
//  ViewController.swift
//  Project8
//
//  Created by Hiroki Ikeuchi on 2020/01/09.
//  Copyright © 2020 ikeh1024. All rights reserved.
//

import Cocoa
import GameplayKit

class ViewController: NSViewController {
    
    var visualEffectView: NSVisualEffectView!
    var gridViewButtons = [NSButton]()
    let gridSize = 10
    let gridMargin: CGFloat = 5
    var gameOverView: GameOverView!
    
    var images = ["elephant", "giraffe", "hippo", "monkey", "panda", "parrot", "penguin", "pig", "rabbit", "snake"]
    var currentLevel = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createLevel()
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
                button.setButtonType(.momentaryChange)
                button.imagePosition = .imageOnly
                button.focusRingType = .none
                button.isBordered = false
                button.action = #selector(imageClicked(_:))
                
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
    
    func generateLayout(items: Int) {
        // reset the game board
        for button in gridViewButtons {
            button.tag = 0
            button.image = nil
        }
        
        // randomize the buttons and animal images
        gridViewButtons = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: gridViewButtons) as! [NSButton]
        images = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: images) as! [String]
        
        // create our tow properties to place animals in pairs
        var numUsed = 0
        var itemCount = 1
        
        // create the odd animal by hand, giving it the tag 2, "correct answer
        let firstButton = gridViewButtons[0]
        firstButton.tag = 2
        firstButton.image = NSImage(named: images[0])
        
        // now we create all the rest of the animals
        for i in 1 ..< items {
            // pull out the button at this location and give it the tag 1, "wrong answer"
            let currentButton = gridViewButtons[i]
            currentButton.tag = 1
            
            // set its image to be the correct animal
            currentButton.image = NSImage(named: images[itemCount])
            
            // mark that we placed another animal in this pair
            numUsed += 1
            
            // if we have placed two animals of this type
            if (numUsed == 2) {
                // reset the counter
                numUsed = 0
                
                // place the next animal type
                itemCount += 1
            }
            
            // if we reached the end of the animal type, we use the same animal type
            if (itemCount == images.count) {
                // go back to the start -1, not 0, because we don't want to place the odd animal
                itemCount = 1 // It's the same as initializing
            }
        }
    }
    
    func gameOver() {
        gameOverView = GameOverView()
        gameOverView.alphaValue = 0
        
        gameOverView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(gameOverView)
        
        gameOverView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        gameOverView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        gameOverView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        gameOverView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        gameOverView.layoutSubtreeIfNeeded()
        
        gameOverView.startEmitting()
        NSAnimationContext.current.duration = 1
        gameOverView.animator().alphaValue = 1
        
    }
    
//    func createLevel() {
//        switch currentLevel {
//        case 1:
//            generateLayout(items: 5)
//        case 2:
//            generateLayout(items: 15)
//        case 3:
//            generateLayout(items: 25)
//        case 4:
//            generateLayout(items: 35)
//        case 5:
//            generateLayout(items: 49)
//        case 6:
//            generateLayout(items: 65)
//        case 7:
//            generateLayout(items: 81)
//        case 8:
//            generateLayout(items: 100)
//        default:
//            gameOver()
//        }
//    }
    
    func createLevel() {
//        if currentLevel == 9 {
        if currentLevel == 2 {
            gameOver()
        } else {
            let numberOfItems = [0, 5, 15, 25, 35, 49, 65, 81, 100]
            generateLayout(items: numberOfItems[currentLevel])
        }
    }
    
    @objc func imageClicked(_ sender: NSButton) {
        // bail out if the user clicked an invisible button
        guard sender.tag != 0 else { return }
        
        if sender.tag == 1 {
            // they clicked the wrong animal
            if currentLevel > 1 {
                // take the current level down by 1 if we can
                currentLevel -= 1
            }
            // create a new layout
            createLevel()
        } else {
            // they clicked the correct animal
            if currentLevel < 9 {
                // take the current level up by 1 if we can
                currentLevel += 1
                createLevel()
            }
        }
    }
    
    override func mouseDown(with event: NSEvent) {
        // don't let mouse clicks bleed ghrough
    }
}

