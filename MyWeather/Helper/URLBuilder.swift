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
    
    public func latitude(latitude: Double) {
        url.append("latitude=\(latitude)")
    }
    
    public func longitude(longitude: Double) {
        url.append("&longitude=\(longitude)")
    }
    
    public func hourly(hourly: [String]) {
        let joinedHourly = hourly.joined(separator: ",")
        url.append("&" + joinedHourly)
    }
    
    public func startDate(start: Date) {
        url.append("&\(start)")
    }
    
    public func endDate(end: Date) {
        url.append("&\(end)")
    }
    
    public func build() -> URL? {
        return URL(string: url)
    }
}
