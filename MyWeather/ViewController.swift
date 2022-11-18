//
//  ViewController.swift
//  MyWeather
//
//  Created by Nicholas Pilotto on 24/10/22.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    private var weatherView: MainWeatherView!
    private var dailyView = SecondaryView()
    
    private let locationManager = CLLocationManager()
    
    private var latitude: CLLocationDegrees = 0
    private var longitude: CLLocationDegrees = 0
    
    private var url: URL?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    
    private func createURL() {
        
        let date = Date.now
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let today = dateFormatter.string(from: date)
        
        url = URLBuilder().latitude(latitude: latitude)
            .longitude(longitude: longitude)
            .hourly(hourly: ["temperature_2m", "relativehumidity_2m", "precipitation", "rain"])
            .daily(dayly: ["weathercode", "temperature_2m_max", "temperature_2m_min", "sunrise", "sunset"])
            .currentWeather(current: true)
            .timezone(timezone: "Europe/Rome")
            .startDate(start: today)
            .endDate(end: today)
            .build()
    }
    
    override func viewDidLayoutSubviews() {
        self.view.backgroundColor = UIColor(rgb: 0x000A17)
        
        weatherView = MainWeatherView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width - 40, height: self.view.frame.height * 2/3))
        
        self.view.addSubview(weatherView)
        self.view.addSubview(dailyView)
        
        weatherView.anchor(self.view.safeAreaLayoutGuide.topAnchor, left: self.view.leftAnchor, bottom: nil, right: self.view.rightAnchor, topConstant: 10, leftConstant: 20, bottomConstant: 0, rightConstant: 20, widthConstant: 0, heightConstant: self.view.frame.height * 2/3)
        dailyView.anchor(weatherView.bottomAnchor, left: self.view.leftAnchor, bottom: self.view.bottomAnchor, right: self.view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        
        latitude = location.coordinate.latitude
        longitude = location.coordinate.longitude
        
        createURL()
        
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

