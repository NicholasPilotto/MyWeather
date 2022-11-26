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
    let hourly_units: Units
    let hourly : WeatherData
    let daily: Daily
    let daily_units: DailyUnits
    let current_weather: CurrentWeather
}

struct CurrentWeather: Codable {
    let temperature: Double
    let windspeed: Double
    let weathercode: Int
    let time: String
}

struct Units: Codable {
    let temperature_2m: String
    let relativehumidity_2m: String
    let precipitation: String
    let rain: String
    let windspeed_10m: String
}

struct WeatherData: Codable {
    let time: [String]
    let temperature_2m: [Double]
    let relativehumidity_2m: [Int]
    let precipitation: [Double]
    let rain: [Double]
    let windspeed_10m: [Double]
    let weathercode: [Int]
}

struct Daily: Codable {
    let temperature_2m_max: [Double]
    let temperature_2m_min: [Double]
    let sunrise: [String]
    let sunset: [String]
}

struct DailyUnits: Codable {
    let temperature_2m_max: String
    let temperature_2m_min: String
    let weathercode: String
}
