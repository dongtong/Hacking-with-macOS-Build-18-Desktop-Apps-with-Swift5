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

extension ViewController: MKMapViewDelegate {
    
    // MARK:- MKMapViewDelegate Methods
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // 1 - convert the annotation to a pin so we can reads its color
        guard let pin = annotation as? Pin else { return nil }
        
        // create an identifier string that will be used to share map pins
        let identifier = "Guess"
        
        // 3 - attempt to dequeue a pin from the re-use queue
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
        
        if annotationView == nil {
            // 4 - there was no pin to reuse, create a new one
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        } else {
            // 5 - we got back a pin to re-use, so update its annotation to the new annotation
            annotationView!.annotation = annotation
        }
        
        // 6 - customize the pin so taht it can show a call out and has a color
        annotationView?.canShowCallout = true
        annotationView?.pinTintColor = pin.color
        
        return annotationView
    }
}
