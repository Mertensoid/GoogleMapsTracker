//
//  Coordinate + Codable.swift
//  GoogleMapsTracker
//
//  Created by admin on 01.12.2022.
//

import Foundation

class Coordinate: Codable {
    var latitude: Double
    var longitude: Double
    
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}
