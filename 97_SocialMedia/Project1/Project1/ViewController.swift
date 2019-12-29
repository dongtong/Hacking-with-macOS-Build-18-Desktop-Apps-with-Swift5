//
//  ViewController.swift
//  Project1
//
//  Created by Hiroki Ikeuchi on 2019/12/29.
//  Copyright © 2019 ikeh1024. All rights reserved.
//

import Cocoa

class ViewController: NSSplitViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    @IBAction func sharedClicked(_ sender: NSView) {
        
        guard let detail = children[1] as? DetailViewController else { return }
        guard let image = detail.imageView.image else { return }
        
        let picker = NSSharingServicePicker(items: [image])
        
        picker.show(relativeTo: .zero, of: sender, preferredEdge: .minY)
    }
    
    
}

