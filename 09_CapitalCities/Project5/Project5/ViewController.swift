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
    
    var cities = [Pin]()
    var currentCity: Pin?
    
    var score = 0 {
        didSet {
            scoreLabel.stringValue = "Score: \(score)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let recognizer = NSClickGestureRecognizer(target: self, action: #selector(mapClicked(recognizer:)))
        mapView.addGestureRecognizer(recognizer)
        
        startNewGame()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    func addPin(at coord: CLLocationCoordinate2D) {
        // make sure we have a city that we're looking for
        guard let actual = currentCity else { return }
        
        // create a pin representing the player's guess, and add it to the map
        let guess = Pin(title: "Your guess", coordinate: coord, color: NSColor.red)
        mapView.addAnnotation(guess)
        
        // also add the correct answer
        mapView.addAnnotation(actual)
        
        // convert both coordinates to map points
        let point1 = MKMapPoint(guess.coordinate)
        let point2 = MKMapPoint(actual.coordinate)
        
        // calculate how many kilometers they were off, then subtract that from 500
        let distance = Int(max(0, 500 - point1.distance(to: point2) / 1000))
        
        // add that to their score; this trigger the property observer
        score += distance
        
        // add an annotation to the correct pin telling the player what their score is
        actual.subtitle = "You scored \(distance)"
        
        // tell the map view to select the correct answer, making it zoom in and show its title and subtitle
        mapView.selectAnnotation(actual, animated: true)
    }
    
    @objc func mapClicked(recognizer: NSClickGestureRecognizer) {
        if mapView.annotations.count == 0 {
            addPin(at: mapView.convert(recognizer.location(in: mapView), toCoordinateFrom: mapView))
        } else {
            mapView.removeAnnotations(mapView.annotations)
            nextCity()
        }
    }
    
    // MARK:- Game Methods
    
    func startNewGame() {
        // clear the score
        score = 0
        
        // create example cities
        cities.append(Pin(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275)))
        cities.append(Pin(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75)))
        cities.append(Pin(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8547, longitude: 2.3508)))
        cities.append(Pin(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5)))
        cities.append(Pin(title: "Washington DC", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667)))
        
        // start playing the game
        nextCity()
    }
    
    func nextCity() {
        if let city = cities.popLast() {
            // make this the city to guess
            currentCity = city
            
            questionLabel.stringValue = "Where is \(city.title!)?"
            
        } else {
            // no more cities
            currentCity = nil
            let alert = NSAlert()
            alert.messageText = "Final score: \(score)"
            alert.runModal()
            
            // start a new game
            startNewGame()
        }
    }
}

extension ViewController: MKMapViewDelegate {
    
    // MARK:- MKMapViewDelegate Methods
    //addAnnotationした際に呼ばれるデリゲートメソッド
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
