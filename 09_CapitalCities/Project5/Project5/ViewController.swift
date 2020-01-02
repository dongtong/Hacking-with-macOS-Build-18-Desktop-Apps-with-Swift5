//
//  ViewController.swift
//  Project5
//
//  Created by Hiroki Ikeuchi on 2020/01/02.
//  Copyright © 2020 ikeh1024. All rights reserved.
//

import Cocoa
import MapKit

class ViewController: NSViewController {
    @IBOutlet var questionLabel: NSTextField!
    @IBOutlet var scoreLabel: NSTextField!
    @IBOutlet var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

