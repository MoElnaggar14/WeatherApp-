//
//  WeatherCell.swift
//  WeatherApp
//
//  Created by Mohammed Elnaggar on 12/13/17.
//  Copyright © 2017 Mohammed Elnaggar. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {


    @IBOutlet weak var weatherTypeImage: UIImageView!
    @IBOutlet weak var daylbl: UILabel!
    @IBOutlet weak var weatherType: UILabel!
    @IBOutlet weak var highTemp: UILabel!
    @IBOutlet weak var lowTemp: UILabel!
    
    
    func ConfigureCell (forcast: Forcast) {
        daylbl.text = forcast.date
        weatherType.text = forcast.weatherType
        highTemp.text = "\(forcast.highTemp)"
        lowTemp.text = "\(forcast.minTemp)"
        weatherTypeImage.image = UIImage(named: forcast.weatherType)
        
    }



}
