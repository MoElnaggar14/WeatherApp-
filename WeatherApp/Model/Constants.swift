//
//  Constants.swift
//  WeatherApp
//
//  Created by Mohammed Elnaggar on 12/12/17.
//  Copyright © 2017 Mohammed Elnaggar. All rights reserved.
//

import Foundation

// API URL That will download data from it 
let Base_Url = "http://api.openweathermap.org/data/2.5/weather?"
let Latitude = "lat="
let Longitude = "&lon="
let app_ID = "&appid="
let API_Key = "917d2e77bca38908e4eba7d4600fd941"

typealias DownloadComplete = () -> ()
let currentWeatherURL = "\(Base_Url)\(Latitude)\(Location.SharedInstance.latitude!)\(Longitude)\(Location.SharedInstance.longitude!)\(app_ID)\(API_Key)"


let forcastWeatherURL = "http://api.weatherbit.io/v2.0/forecast/daily?&lat=\(Location.SharedInstance.latitude!)&lon=\(Location.SharedInstance.longitude!)&key=6ddafbe185b84c23aecaadbc6afc3bde"


