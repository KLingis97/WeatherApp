//
//  Repo.swift
//  WeatherApp
//
//  Created by Kyriakos Lingis on 18/11/2023.
//

import Foundation
import UIKit

class Repository {
    static let shared = Repository()
    
    public func fetchCurrentWeatherData(url: String, completion: @escaping ((Result<WeatherData?,Error>)->Void)) {
        
        APIService.shared.fetchCurrentWeatherData(url: url, completion: { result in
            switch result {
            case .success(let response):
                do{
                    guard let response else { return }
                    let decoder = JSONDecoder()
                    let weatherData = try decoder.decode(WeatherData.self, from: response)
                    print(weatherData)
                    completion(.success(weatherData))
                } catch {
                    print(error)
                }
            case .failure(let failure):
                print("error: \(String(describing: failure.errorDescription))")
                completion(.failure(failure))
            }
            
        })
        
    }
    
    public func fetchCurrentWeatherIcon(url: String, completion: @escaping ((Result<UIImage?,Error>)->Void)) {
        
        APIService.shared.fetchCurrentWeatherIcon(url: url, completion: { result in
            switch result {
            case .success(let response):
                guard let response else { return }
                let urlImage = UIImage(data: response,scale: 1)
                completion(.success(urlImage))
                
            case .failure(let failure):
                print("error: \(String(describing: failure.errorDescription))")
                completion(.failure(failure))
            }
            
        })
    }
}
