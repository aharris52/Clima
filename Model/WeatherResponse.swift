//
//  WeatherData.swift
//  Clima
//
//  Created by Andrew Harris on 8/27/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

struct WeatherResponse: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
    
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let id: Int
    let description: String
    
}
