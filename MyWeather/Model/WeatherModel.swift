//
//  WeatherModel.swift
//  MyWeather
//
//  Created by Nicholas Pilotto on 03/11/22.
//

import Foundation

struct WeatherModel: Codable {
    let latitude: Double
    let longitude: Double
    let elevation: Double
    let hourlyUnits: Units
    let data: WeatherData
}

struct Units: Codable {
    let time: String
    let temperature2m: String
    let rain: String
    let windspeed10m: String
}

struct WeatherData: Codable {
    let time: [String]
    let temperature2m: [Double]
    let rain: [Double]
    let windspeed10m: [Double]
}
