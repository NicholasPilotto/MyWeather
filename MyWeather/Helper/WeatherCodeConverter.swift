//
//  WeatherCodeConverter.swift
//  MyWeather
//
//  Created by Nicholas Pilotto on 21/11/22.
//

import Foundation


final class WeatherCodeConverter {
    public static func convert(code: Int) -> (String, String, String) {
        
        let hour = Calendar.current.component(.hour, from: Date.now)
        
        let period = hour >= 5 && hour <= 17 ? "day" : "night"
        
        switch code {
        case 0:
            return ("clear", period, "Soleggiato")
        case 1, 2, 3:
            return ("cloudy", period, "Nuvoloso")
        case 45, 48:
            return ("foggy", period, "Nebbia")
        case 51, 53, 55:
            return ("drizzle", period, "Pioggerellina")
        case 61, 63, 65:
            return ("rain", period, "Pioggia")
        case 71, 73, 75:
            return ("snow", period, "Neve")
        case 80, 81, 82:
            return ("thunderstorm", period, "Tempesta")
        default:
            return ("clear", period, "Soleggiato")
        }
    }
}
