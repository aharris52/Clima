//
//  WeatherManager.swift
//  Clima
//
//  Created by Andrew Harris on 8/25/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

struct WeatherManager {
    
    let weatherURL = "http://api.openweathermap.org/data/2.5/weatherappid=c55cb732122714b2f4b5ca950bda140d&units=imperial"
    
    func fetchWeather(cityName: String){
        let urlString = "\(weatherURL)&q=\(cityName)"
        //  for debugging
        print(urlString)
    }
    
    
}
