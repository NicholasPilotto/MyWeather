//
//  MainViewViewModel.swift
//  MyWeather
//
//  Created by Nicholas Pilotto on 18/11/22.
//

import Foundation

struct MainViewViewModel {
    let city: String
    let weatherImage: String
    let temperature: Double
    let temperatureUnit: String
    let weather: String
    let date: String
    let info: [MainViewInfo]
}

struct MainViewInfo {
    let infoIcon: String
    let infoValue: Any
    let valueUnit: String
    let infoName: String
}
