//
//  AppConfiguration.swift
//  WeatherApp
//
//  Created by Kyriakos Lingis on 18/11/2023.
//

import Foundation

struct ApiConfiguration {
    
    static let shared = ApiConfiguration()
    
    let baseURL = "https://api.openweathermap.org/data/3.0/onecall?"
    let apiKey = "d62d88c793046613d90aa7c4b0967c43"
    let exclude = "current,minutely,hourly,daily,alerts"
    let metric = "metric"
 
}
