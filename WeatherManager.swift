//
//  WeatherManager.swift
//  Clima
//
//  Created by Andrew Harris on 8/25/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

struct WeatherManager {
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?&appid=a8d351b8a21663816f135c6653a4aa7c&units=imperial"
    //let weatherURL = "https://api.openweathermap.org/data/2.5/weather?&appid=c55cb732122714b2f4b5ca950bda140d&units=imperial"
    
    
    func fetchWeather(cityName: String){
        let urlString = "\(weatherURL)&q=\(cityName)"
        //  for debugging
        print(urlString)
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString : String) {
        //1.  create a url
        if let url = URL(string: urlString){
            //2.  create url session
            let session = URLSession(configuration: .default)
            //3.  give the session a task
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    self.parseJSON(weatherData: safeData)
                }
            }
            //4.  start the task
            task.resume()
        }
    }
    
    func parseJSON(weatherData: Data) {
        let decoder = JSONDecoder()
        //the use of .self converts WeatherData to the correct type
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            print(decodedData.name)
        } catch {
            print(error)
        }
    }
}
