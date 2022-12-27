//
//  WeatherModel.swift
//  WeatherCamStatus
//
//  Created by Mohamed Makhlouf Ahmed on 20/11/2022.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let description: String
    let id: Int
}


