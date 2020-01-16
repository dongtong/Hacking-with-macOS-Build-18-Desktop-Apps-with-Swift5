//
//  ViewController.swift
//  Project12
//
//  Created by Hiroki Ikeuchi on 2020/01/16.
//  Copyright © 2020 ikeh1024. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    var imageView: NSImageView!
    var currentAnimation = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView = NSImageView(image: NSImage(named: NSImage.Name("penguin"))!)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.frame = CGRect(x: 272, y: 172, width: 256, height: 256)
        
        imageView.wantsLayer = true
//        imageView.layer?.backgroundColor = NSColor.red.cgColor
        view.addSubview(imageView)
        
        let button = NSButton(title: "Click me", target: self, action: #selector(animate))
        button.frame = CGRect(x: 10, y: 10, width: 100, height: 30)
        view.addSubview(button)
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @objc func animate() {
        
        
    }
    

}

