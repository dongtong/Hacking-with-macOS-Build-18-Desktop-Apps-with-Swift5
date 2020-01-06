//
//  Photo.swift
//  Project7
//
//  Created by Hiroki Ikeuchi on 2020/01/05.
//  Copyright © 2020 ikeh1024. All rights reserved.
//

import Cocoa

class Photo: NSCollectionViewItem {

    let selectedBorderThickness: CGFloat = 3
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                view.layer?.borderWidth = selectedBorderThickness
            } else {
                view.layer?.borderWidth = 0
            }
        }
    }
    
    override var highlightState: NSCollectionViewItem.HighlightState {
        didSet {
            if highlightState == .forSelection {
                view.layer?.borderWidth = selectedBorderThickness
            } else {
                if !isSelected {
                    view.layer?.borderWidth = 0 // Selected but highlighted for deselection
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        view.wantsLayer = true
        view.layer?.borderColor = NSColor.blue.cgColor
    }
    
}
