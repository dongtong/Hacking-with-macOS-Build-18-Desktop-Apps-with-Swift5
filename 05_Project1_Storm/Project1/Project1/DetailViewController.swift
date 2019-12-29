//
//  DetailViewController.swift
//  Project1
//
//  Created by Hiroki Ikeuchi on 2019/12/29.
//  Copyright © 2019 ikeh1024. All rights reserved.
//

import Cocoa

class DetailViewController: NSViewController {

  @IBOutlet var imageView: NSImageView!
  
  override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    func imageSelected(name: String) {
        imageView.image = NSImage(named: name)
    }
    
}
