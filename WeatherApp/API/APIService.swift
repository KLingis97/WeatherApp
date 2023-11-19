//
//  APIService.swift
//  WeatherApp
//
//  Created by Kyriakos Lingis on 18/11/2023.
//

import Foundation
import Alamofire

protocol APIServiceProtocol {
    
    func fetchCurrentWeatherData(url:String ,completion: @escaping (Result<Data?, AFError>) -> Void)
    func fetchCurrentWeatherIcon(url: String,completion: @escaping (Result<Data?, AFError>) -> Void)
}

class APIService {
    
    static let shared: APIServiceProtocol = APIService()

}

extension APIService: APIServiceProtocol {
    func fetchCurrentWeatherIcon(url: String, completion: @escaping (Result<Data?, Alamofire.AFError>) -> Void) {
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil)
            .response { response in
                completion(response.result)
            }
    }
    
    func fetchCurrentWeatherData(url:String ,completion: @escaping (Result<Data?, AFError>) -> Void) {
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil)
            .response { response in
                completion(response.result)
            }
    }
}
