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
    let hourly : WeatherData
    let daily: Daily
}

struct CurrentWeather: Codable {
    let temperature: Double
    let windspeed: Double
    let weathercode: Int
}

struct Units: Codable {
    let time: [String]
    let temperature2m: String
    let relaviveHumidity2m: String
    let precipitation: String
    let rain: String
    let windspeed10m: String
}

struct WeatherData: Codable {
    let time: [String]
    let temperature2m: [Double]
    let relativeHumidity2m: [Int]
    let precipitation: [Double]
    let rain: [Double]
    let windspeed10m: [Double]
}

struct Daily: Codable {
    let temperature2mMax: [Double]
    let temperature2mMin: [Double]
    let sunrise: [Date]
    let sunset: [Date]
}
