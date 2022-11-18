//
//  URLBuilder.swift
//  MyWeather
//
//  Created by Nicholas Pilotto on 03/11/22.
//

import Foundation

public class URLBuilder {
    
    private let urlAddress: String = "https://api.open-meteo.com/"
    private let urlVersion: String = "v1/"
    private let urlOptions: String = "forecast?"
    
    private var url: String
    
    public init() {
        url = urlAddress + urlVersion + urlOptions
    }
    
    public func latitude(latitude: Double) -> URLBuilder {
        url.append("latitude=\(latitude)&")
        return self
    }
    
    public func longitude(longitude: Double) -> URLBuilder {
        url.append("longitude=\(longitude)&")
        return self
    }

    public func hourly(hourly: [String]) -> URLBuilder {
        let joinedHourly = hourly.joined(separator: ",")
        url.append("hourly=" + joinedHourly + "&")
        return self
    }
    
    public func daily(dayly: [String]) -> URLBuilder {
        let joinedDayly = dayly.joined(separator: ",")
        url.append("daily=" + joinedDayly + "&")
        return self
    }
    
    public func currentWeather(current: Bool) -> URLBuilder {
        url.append("current_weather=\(current)&")
        return self
    }
    
    public func timezone(timezone: String) -> URLBuilder {
        url.append("timezone=" + timezone + "&")
        return self
    }
    
    public func startDate(start: String) -> URLBuilder {
        url.append("start_date=" + start + "&")
        return self
    }
    
    public func endDate(end: String) -> URLBuilder {
        url.append("end_date=" + end + "&")
        return self
    }
    
    public func build() -> URL? {
        url.removeLast()
        return URL(string: url)
    }
}
