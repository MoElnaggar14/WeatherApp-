//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by Mohammed Elnaggar on 12/12/17.
//  Copyright © 2017 Mohammed Elnaggar. All rights reserved.
//

import  UIKit
import Alamofire

class CurrentWeather {
    // Declare Variables That be Called from API Current day
    
    private var _cityName: String!
    private var _date: String!
    private var _weatherType: String!
    private var _currentTemp: Double!
    private var _HighTemp: Double!
    private var _MinTemp: Double!
    
    //make data encapsulation
    
    var cityName: String {
        if _cityName == nil {
            _cityName = ""
        }
        return _cityName
    }
    var date: String {
        if _date == nil {
            _date = ""
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        let currentDate = dateFormatter.string(from: Date())
        self._date = "Today, \(currentDate)"
        return _date
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    
    var currentTemp: Double {
        if _currentTemp == nil {
            _currentTemp = 0.0
        }
        return _currentTemp
    }
    
    
    var HighTemp: Double {
        if _HighTemp == nil {
            _HighTemp = 0.0
        }
        return _HighTemp
    }
    
    var MinTemp: Double {
        if _MinTemp == nil {
            _MinTemp = 0.0
        }
        return _MinTemp
    }
    
    func downloadWeatherDetails (completed: @escaping DownloadComplete) {
        //Download weather data
        let currentWeatherUrl = URL(string: currentWeatherURL)!
        Alamofire.request(currentWeatherUrl).responseJSON { response in
            let result = response.result
            
            // parse JSON data
            if let dict = result.value as? Dictionary <String, AnyObject> {
                if let name = dict["name"] as? String {
                    self._cityName = name
                    print(self._cityName)
                }
                if let weather = dict["weather"] as? [Dictionary<String, AnyObject>] {
                    if let weatherType = weather[0]["main"] as? String {
                        self._weatherType = weatherType
                        print(self._weatherType)
                    }
                }
                if let main = dict["main"] as? Dictionary<String, AnyObject> {
                    if let currentTemp = main["temp"] as? Double {
                        let celsiusToKelvinC = currentTemp - 273.12
                        self._currentTemp = Double(round(celsiusToKelvinC))
                        print(self._currentTemp)
                    }
                   /*
                    if let highTemp = main["temp_max"] as? Double {
                        let celsiusToKelvinH = highTemp - 273.12
                        self._HighTemp = Double(round(celsiusToKelvinH))
                        print(self.HighTemp)
                    }
                    if let minTemp = main["temp_min"] as? Double {
                        let celsiusToKelvinM = minTemp - 273.12
                        self._MinTemp = Double(round(celsiusToKelvinM))
                        print(self._MinTemp)
                    } */
            }
                
        }
        completed()
    }
    


    }
    
    
}
