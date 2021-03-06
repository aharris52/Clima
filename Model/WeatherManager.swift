//
//  WeatherManager.swift
//  Clima
//
//  Created by Andrew Harris on 8/25/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?&appid=a8d351b8a21663816f135c6653a4aa7c&units=imperial"
    //let weatherURL = "https://api.openweathermap.org/data/2.5/weather?&appid=c55cb732122714b2f4b5ca950bda140d&units=imperial"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String){
        let urlString = "\(weatherURL)&q=\(cityName)"
        //  for debugging
        //print(urlString)
        performRequest(with: urlString)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        //  for debugging
        //print(urlString)
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString : String) {
        //1.  create a url
        if let url = URL(string: urlString){
            //2.  create url session
            let session = URLSession(configuration: .default)
            //3.  give the session a task
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    //print(error!)
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let weather = self.parseJSON(safeData) {
                        //let weatherVC = WeatherViewController()
                        //weatherVC.didUpdateWeather(weather: weather)
                        
                        // Pretend we know what design patterns are and
                        // decouple this struct by using a delegate pattern.
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            //4.  start the task
            task.resume()
        }
    }
    
    func parseJSON(_ jsonWeatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        //  the use of .self converts WeatherData to the correct type
        //  and removes ambiguity as to who is using/calling a method from
        //  within a closure
        do {
            let response = try decoder.decode(WeatherResponse.self, from: jsonWeatherData)
        
            let id = response.weather[0].id
            let name = response.name
            let temp = response.main.temp
            // create WeatherModel to pop image to ui
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            print(id)
            print(name)
            print(temp)
            print(weather.conditionName)
            print(weather.temperatureString)
            return weather
        } catch {
            self.delegate?.didFailWithError(error: error)
            //print(error)
            return nil
        }
    }
}


