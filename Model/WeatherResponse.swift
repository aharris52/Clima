//
//  WeatherData.swift
//  Clima
//
//  Created by Andrew Harris on 8/27/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

//Codeable is a type alias to the combination
//of two common protocols used in conjunction.
//The "Encodable" and "Deodable" are combined
//in this protocol.

struct WeatherResponse: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
    let id: Int
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let id: Int
    let description: String
    
}
