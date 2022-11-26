//
//  ViewController.swift
//  MyWeather
//
//  Created by Nicholas Pilotto on 24/10/22.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    private var weatherView = MainWeatherView()
    private var dailyView = SecondaryView()
    
    private let locationManager = CLLocationManager()
    
    private var latitude: CLLocationDegrees?
    private var longitude: CLLocationDegrees?
    
    private var url: URL?
    
    private let date = Date.now
    private let dateFormatter = DateFormatter()
    
    private var today: String = ""
    
    private let onceToken = NSUUID().uuidString
    
    private var spinner = UIActivityIndicatorView()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.requestLocation()
                
        self.startSpinnerView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func startSpinnerView() {
        self.spinner.startAnimating()
    }
    
    private func hideSpinnerView() {
        self.spinner.stopAnimating()
        self.spinner.removeFromSuperview()
    }
    
    private func request() {
        Service.shared.fetch(url: url) { [weak self] result in

                guard let self = self else {
                    return
                }
                switch result {
                case .success(let success):
                    DispatchQueue.main.async {
//                        print(success)
                        let codeConverted = WeatherCodeConverter.convert(code: success.current_weather.weathercode)
                        let image = codeConverted.1 + "-" + codeConverted.0 + "-icon"
                        
                        let solar = success.daily.sunrise[0].suffix(5) + "-" + success.daily.sunset[0].suffix(5)
                        let maxMinTemp = "\(success.daily.temperature_2m_min[0])" + "/" + "\(success.daily.temperature_2m_max[0])" + success.daily_units.temperature_2m_max
                        
                        let windMainInfo = MainViewInfo(infoIcon: "wind", infoValue: success.current_weather.windspeed, valueUnit: success.hourly_units.windspeed_10m, infoName: "Vento")
                        let humidityMainInfo = MainViewInfo(infoIcon: "sunrise-icon", infoValue: solar, valueUnit: "", infoName: "Ciclo solare")
                        let rainMainInfo = MainViewInfo(infoIcon: "temperature-heat-icon", infoValue: maxMinTemp, valueUnit: "", infoName: "Min/Max")
                        
                        let info = [windMainInfo, humidityMainInfo, rainMainInfo]
                        
                        let formatted = Date().formatted(date: .long, time: .omitted)
                        
                        let hourlyIndex = success.hourly.time.firstIndex(of: "\(self.today)T\(success.current_weather.time.suffix(5))") ?? 0
                        var secondaryViewViewModel = [SecondaryViewViewModel]()
                        
                        for i in (hourlyIndex + 1)...(hourlyIndex + 5) {
                            let converted = WeatherCodeConverter.convert(code: success.hourly.weathercode[i])
                            secondaryViewViewModel.append(SecondaryViewViewModel(temperature: success.hourly.temperature_2m[i], temperatureUnit: success.hourly_units.temperature_2m, iconImage: "\(converted.1)-\(converted.0)-icon", time: String(success.hourly.time[i].suffix(5))))
                        }
                        
                        let mainWeatherViewModel = MainViewViewModel(city: "MyWeather", weatherImage: image, temperature: success.current_weather.temperature, temperatureUnit: success.hourly_units.temperature_2m, weather: codeConverted.2, date: formatted, info: info)
                        
                        self.weatherView.configure(viewModel: mainWeatherViewModel)
                        self.dailyView.configure(viewModels: secondaryViewViewModel)
                        self.hideSpinnerView()
                    }
                    break
                case .failure(let failure):
                    print(failure)
                    break
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
        
        self.view.addSubview(weatherView)
        self.view.addSubview(dailyView)
        
        self.spinner.clipsToBounds = true
        self.spinner.layer.cornerRadius = 15
        self.spinner.backgroundColor = .systemBackground.withAlphaComponent(0.8)
        
        self.view.addSubview(spinner)
        
        self.spinner.anchor(self.view.centerYAnchor, left: self.view.centerXAnchor, bottom: nil, right: nil, topConstant: -50, leftConstant: -50, bottomConstant: 0, rightConstant: 0, widthConstant: 100, heightConstant: 100)
        
        weatherView.anchor(self.view.safeAreaLayoutGuide.topAnchor, left: self.view.leftAnchor, bottom: nil, right: self.view.rightAnchor, topConstant: 10, leftConstant: 20, bottomConstant: 0, rightConstant: 20, widthConstant: 0, heightConstant: self.view.frame.height * 2/3)
        dailyView.anchor(weatherView.bottomAnchor, left: self.view.leftAnchor, bottom: self.view.bottomAnchor, right: self.view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        
        self.latitude = location.coordinate.latitude
        self.longitude = location.coordinate.longitude
        
        DispatchQueue.once(token: onceToken) {
            self.createURL()
            self.request()
        }
    
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }

}

