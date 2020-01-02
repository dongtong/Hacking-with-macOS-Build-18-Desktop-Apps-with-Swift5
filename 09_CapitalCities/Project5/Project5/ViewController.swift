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

        let recognizer = NSClickGestureRecognizer(target: self, action: #selector(mapClicked(recognizer:)))
        mapView.addGestureRecognizer(recognizer)
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    func addPin(at coord: CLLocationCoordinate2D) {
        let guess = Pin(title: "Your guess", coordinate: coord, color: NSColor.red)
        mapView.addAnnotation(guess)
    }
    
    @objc func mapClicked(recognizer: NSClickGestureRecognizer) {
        let location = recognizer.location(in: mapView)
        let coordinate = mapView.convert(location, toCoordinateFrom: mapView)   // mapView基準の座標に変換
        addPin(at: coordinate)
    }
    
}

