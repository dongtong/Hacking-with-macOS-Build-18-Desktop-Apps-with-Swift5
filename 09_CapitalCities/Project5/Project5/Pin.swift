//
//  Pin.swift
//  Project5
//
//  Created by Hiroki Ikeuchi on 2020/01/02.
//  Copyright © 2020 ikeh1024. All rights reserved.
//

import Cocoa
import MapKit

class Pin: NSObject, MKAnnotation {

    var title: String?
    var subtitle: String?
    var coordinate: CLLocationCoordinate2D
    var color: NSColor
    
    init(title: String, coordinate: CLLocationCoordinate2D, color: NSColor = NSColor.green) {
        self.title = title
        self.coordinate = coordinate
        self.color = color
    }
}
