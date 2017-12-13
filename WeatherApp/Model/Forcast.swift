//
//  Forcast.swift
//  WeatherApp
//
//  Created by Mohammed Elnaggar on 12/13/17.
//  Copyright © 2017 Mohammed Elnaggar. All rights reserved.
//

import UIKit
import Alamofire

class Forcast {
    

    
    // Declare Variables That be Called from API future days
    private var _date: String!
    private var _weatherType: String!
    private var _highTemp: Double!
    private var _minTemp: Double!
    
    //make data encapsulation
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        return _date
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    
    var highTemp: Double {
        if _highTemp == nil {
            _highTemp = 0.0
        }
        return _highTemp
    }
    
    var minTemp: Double {
        if _minTemp == nil {
            _minTemp = 0.0
        }
        return _minTemp
    }
    

    
    
    
    init(weatherdict: Dictionary<String, AnyObject>) {
        if let max_temp = weatherdict["max_temp"] as? Double {
            self._highTemp = max_temp
        }
        
        if let min_temp = weatherdict["min_temp"] as? Double {
            self._minTemp = min_temp
        }
        if let weather = weatherdict["weather"] as? Dictionary<String, AnyObject> {
            if let description = weather["description"] as? String {
                self._weatherType = description
            }
        }
        
        if let date = weatherdict["ts"] as? Double {
            let unixConverterDate = Date(timeIntervalSince1970: date)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .full
            dateFormatter.dateFormat = "EEEE"
            dateFormatter.timeStyle = .none
            self._date = unixConverterDate.dayOfTheWeek()
        }
        

    }
    

    
    
}

extension Date {
    func dayOfTheWeek () -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
}
