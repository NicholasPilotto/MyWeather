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
    
    private var latitude: CLLocationDegrees?
    private var longitude: CLLocationDegrees?
    
    private var url: URL?
    
    private let date = Date.now
    private let dateFormatter = DateFormatter()
    
    private var today: String = ""
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        locationManager.requestWhenInUseAuthorization()
        
        
        self.latitude = locationManager.location?.coordinate.latitude
        self.longitude = locationManager.location?.coordinate.longitude
        
        createURL()
        request()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func request() {
        Service.shared.fetch(url: url) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else {
                    return
                }
                switch result {
                case .success(let success):
                    print(success)
                    let codeConverted = WeatherCodeConverter.convert(code: success.current_weather.weathercode)
                    let image = codeConverted.0 + "-" + codeConverted.1
                    
                    let windMainInfo = MainViewInfo(infoIcon: "wind", infoValue: success.current_weather.windspeed, valueUnit: success.hourly_units.windspeed_10m, infoName: "wind")
                    let humidityMainInfo = MainViewInfo(infoIcon: "drop", infoValue: success.current_weather.temperature, valueUnit: success.hourly_units.windspeed_10m, infoName: "humidity")
                    let rainMainInfo = MainViewInfo(infoIcon: "rain", infoValue: success.current_weather.temperature, valueUnit: success.hourly_units.windspeed_10m, infoName: "wind")
                    
                    let info = [windMainInfo, humidityMainInfo, rainMainInfo]
                    
                    let mainWeatherViewModel = MainViewViewModel(city: "MyWeather", weatherImage: image, temperature: success.current_weather.temperature, temperatureUnit: success.hourly_units.temperature_2m, weather: codeConverted.0, date: self.today, info: info)
                    
                    self.weatherView.configure(viewModel: mainWeatherViewModel)
                    
                    break
                case .failure(let failure):
                    print(failure)
                    break
                }
            }
            
        }
    }
    
    private func createURL() {
        
        today = dateFormatter.string(from: date)
        guard let lat = self.latitude, let lon = self.longitude else {
            return
        }
        
        url = URLBuilder().latitude(latitude: lat)
            .longitude(longitude: lon)
            .hourly(hourly: ["weathercode", "temperature_2m", "relativehumidity_2m", "precipitation", "rain", "windspeed_10m"])
            .daily(daily: ["weathercode", "temperature_2m_max", "temperature_2m_min", "sunrise", "sunset"])
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

}

