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
    var currentAnimation = 7
    
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
        switch currentAnimation {
        case 0:
            NSAnimationContext.current.duration = 2
            imageView.animator().alphaValue = 0
        case 1:
            imageView.animator().alphaValue = 1
        case 2:
            NSAnimationContext.current.allowsImplicitAnimation = true
            imageView.alphaValue = 0
        case 3:
            imageView.alphaValue = 1
        case 4:
            imageView.animator().frameCenterRotation = 90
        case 5:
            imageView.animator().frameCenterRotation = 0
        case 6:
            let animation = CABasicAnimation(keyPath: "opacity")
            animation.fromValue = 1
            animation.toValue = 0
            imageView.layer?.add(animation, forKey: nil)
        case 7:
            let animation = CABasicAnimation(keyPath: "opacity")
            animation.fromValue = 1
            animation.toValue = 0
            imageView.layer?.opacity = 0
            imageView.layer?.add(animation, forKey: nil)
        case 8:
            imageView.animator().alphaValue = 1 // 1:不透明
        case 9:
            imageView.layer?.opacity = 1
        default:
            currentAnimation = 0
            animate()
            return
        }
        currentAnimation += 1
    }
    

}

