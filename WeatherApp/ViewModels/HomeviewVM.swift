//
//  MainviewVM.swift
//  WeatherApp
//
//  Created by Kyriakos Lingis on 18/11/2023.
//

import Foundation
import UIKit

class HomeviewVM {
    
    var selectedTemperature: TemperatureType = .celsius
    var weatherData: WeatherData?
    var currentWeatherIcon: UIImage?
    
    func getCurrentTime() -> String {
        let currentDate = Date()
        
        let formatter = DateFormatter()
        
        formatter.timeStyle = .short
        formatter.dateStyle = .none
        
        return formatter.string(from: currentDate)
    }
    
    func convertTemperature(temperatureType: TemperatureType) {
        
        switch temperatureType {
        case .celsius:
            selectedTemperature = .fahrenheit
            
            let farTemp = (((weatherData?.current?.temp ?? 0) * 9) + 160) / 5
            let fTempFeelsLike = (((weatherData?.current?.feels_like ?? 0) * 9) + 160) / 5
            
            weatherData?.current?.temp = farTemp
            weatherData?.current?.feels_like = fTempFeelsLike
            
            break
        case .fahrenheit:
            selectedTemperature = .celsius
            
            let cTemp = (((weatherData?.current?.temp ?? 0) - 32) * 5) / 9
            let cTempFeelsLike = (((weatherData?.current?.feels_like ?? 0) - 32) * 5) / 9
            
            weatherData?.current?.temp = cTemp
            weatherData?.current?.feels_like = cTempFeelsLike
            
            break
        }
        
    }
    
    func fetchCurrentWeatherData(lat: String, lon: String, exclude: String? = nil, completion: @escaping ((Bool) -> Void)) {
        var url: String
        if let exclude = exclude {
            url = ApiConfiguration.shared.baseURL + "lat=" + lat + "&lon=" + lon + "&exclude=" + exclude + "&units=metric&appid=" + ApiConfiguration.shared.apiKey
        } else {
            url = ApiConfiguration.shared.baseURL + "lat=" + lat + "&lon=" + lon + "&units=metric&appid=" + ApiConfiguration.shared.apiKey
        }
        
        Repository.shared.fetchCurrentWeatherData(url: url) { result in
            
            switch result {
            case .success(let data):
                self.selectedTemperature = .celsius
                self.weatherData = data
                completion(true)
            case .failure(let error):
                print(error)
                completion(false)
            }
            
        }
    }
    
    func fetchImageFromUrl(completion: @escaping ((Bool) -> Void)) {
        let url = weatherData?.current?.weather[0].iconURL ?? ""
        
        Repository.shared.fetchCurrentWeatherIcon(url: url, completion: { result in
            
            switch result {
            case .success(let imageData):
                self.currentWeatherIcon = imageData
                completion(true)
            case .failure(let error):
                print(error)
                completion(false)
            }
        })
    }
}
