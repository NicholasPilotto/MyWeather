//
//  DeviceLocationManager.swift
//  MyWeather
//
//  Created by Nicholas Pilotto on 24/11/22.
//

import Foundation
import CoreLocation

class DeviceLocationManager: NSObject, CLLocationManagerDelegate {
       
    private var latitude: CLLocationDegrees?
    private var longitude: CLLocationDegrees?
    
    private static let instance = DeviceLocationManager()
    
    public static let shared: DeviceLocationManager = {
        return instance
    }()
    
    private let locationManager = CLLocationManager()
    
    private override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    public func getCoordinates() -> (CLLocationDegrees?, CLLocationDegrees?) {
        return (latitude, longitude)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        
        latitude = location.coordinate.latitude
        longitude = location.coordinate.longitude
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
