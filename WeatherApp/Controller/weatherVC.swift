//
//  weatherVC.swift
//  WeatherApp
//
//  Created by Mohammed Elnaggar on 12/12/17.
//  Copyright © 2017 Mohammed Elnaggar. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire

class weatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {

    @IBOutlet weak var datelbl: UILabel!
    @IBOutlet weak var currentTemplbl: UILabel!
    @IBOutlet weak var locationlbl: UILabel!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var currentWeatherTypelbl: UILabel!
    
    @IBOutlet weak var tableview: UITableView!
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    
    let currentWeatherDetails = CurrentWeather()
    
    
    // Declare Array to append weatherdict in it
    var forcast = [Forcast]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set my location to keep track your location
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest // dtermine best cordinates
        locationManager.requestWhenInUseAuthorization() // request the user to allow location that will use in app
        locationManager.startMonitoringSignificantLocationChanges() // keep track the GSP of Phone
        
        
        tableview.delegate = self
        tableview.dataSource = self
        
       // print(currentWeatherURL)
       // print(forcastWeatherURL)
        
        
    
        
       
        
    }
    
    // Working Location before Call data from API
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationAuthnicStatus()
    }
    
    //Check the AuthinStatus
    func locationAuthnicStatus () {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            currentLocation = locationManager.location
            Location.SharedInstance.latitude = currentLocation.coordinate.latitude
            Location.SharedInstance.longitude = currentLocation.coordinate.longitude
            
            currentWeatherDetails.downloadWeatherDetails {
                // Update Main UI
                self.DownloadForcastDetails() {
                    self.UpdateMainUI()
                }
                
            }
            
            
            
        } else {
            locationManager.requestWhenInUseAuthorization()
            locationAuthnicStatus()
        }
    }
    


    
    
    func DownloadForcastDetails (completed: @escaping DownloadComplete) {
        
        // download forcast data
        let forcastURL = URL(string: forcastWeatherURL)!
        Alamofire.request(forcastURL).responseJSON { response in
            let result = response.result
            // parse JSON data
            if let dict = result.value as? Dictionary<String, AnyObject> {
                if let data = dict["data"] as? [Dictionary<String, AnyObject>] {
                    for obj in data {
                        let forcast = Forcast(weatherdict: obj)
                        self.forcast.append(forcast)
                        
                    }
                    self.forcast.remove(at: 0)
                    self.tableview.reloadData()
                }
            }
            completed()
        }
        
    }
    
    // set tableview to work
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forcast.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableview.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? WeatherCell {
           let forcast = self.forcast[indexPath.row]
            cell.ConfigureCell(forcast: forcast)
            return cell
        }
        
        return WeatherCell()
    }
    
    func UpdateMainUI () {
        datelbl.text = currentWeatherDetails.date
        currentTemplbl.text = "\(currentWeatherDetails.currentTemp)"
        locationlbl.text = currentWeatherDetails.cityName
        currentWeatherImage.image = UIImage(named: currentWeatherDetails.weatherType)
        currentWeatherTypelbl.text = currentWeatherDetails.weatherType
    }




}

