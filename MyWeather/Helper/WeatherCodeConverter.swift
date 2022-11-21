//
//  WeatherCodeConverter.swift
//  MyWeather
//
//  Created by Nicholas Pilotto on 21/11/22.
//

import Foundation


final class WeatherCodeConverter {
    public static func convert(code: Int) -> (String, String) {
        
        let hour = Calendar.current.component(.hour, from: Date.now)
        
        let period = hour >= 5 && hour <= 17 ? "day" : "night"
        
        switch code {
        case 0:
            return ("clear", period)
        case 1, 2, 3:
            return ("cloudy", period)
        case 45, 48:
            return ("foggy", period)
        case 51, 53, 55:
            return ("drizzle", period)
        case 61, 63, 65:
            return ("rain", period)
        case 71, 73, 75:
            return ("snow", period)
        case 80, 81, 82:
            return ("thunderstorm", period)
        default:
            return ("clear", period)
        }
    }
}
