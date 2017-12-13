//
//  Location.swift
//  WeatherApp
//
//  Created by Mohammed Elnaggar on 12/13/17.
//  Copyright © 2017 Mohammed Elnaggar. All rights reserved.
//

import CoreLocation

class Location {
    
    static var SharedInstance = Location()
    init() {}
    
    var latitude: Double!
    var longitude: Double!
}
