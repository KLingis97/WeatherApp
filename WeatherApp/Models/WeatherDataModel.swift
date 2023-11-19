//
//  WeatherDataModel.swift
//  WeatherApp
//
//  Created by Kyriakos Lingis on 18/11/2023.
//

import Foundation

struct WeatherData: Codable {
    
    var lat: Double
    var lon: Double
    var timezone: String
    var timezone_offset: Int
    var current: CurrentWeather?
    var minutely: [MinutelyWeather]?
    var hourly: [HourlyWeather]?
    var daily: [DailyWeather]?
    var alerts: [WeatherAlert]?
    
}

struct CurrentWeather: Codable {
    var dt: Int
    var sunrise: Int
    var sunset: Int
    var temp: Double
    var feels_like: Double
    var pressure: Int
    var humidity: Int
    var dew_point: Double
    var uvi: Double
    var clouds: Int
    var visibility: Int
    var wind_speed: Double
    var wind_deg: Int
    var wind_gust: Double?
    var rain: Rain?
    var snow: Snow?
    var weather: [Weather]
}

struct Rain: Codable {
    var perHour: Double?
}

struct Snow: Codable {
    var perHour: Double?
}

struct Weather: Codable {
    var id: Int
    var main: String
    var description: String
    var icon: String
    var iconURL: String {
        return "https://openweathermap.org/img/wn/\(icon)@2x.png"
    }
}

struct MinutelyWeather: Codable {
    var dt: Int
    var precipitation: Int
    
}

struct HourlyWeather: Codable {
    var dt: Int
    var temp: Double
    var feels_like: Double
    var pressure: Int
    var humidity: Int
    var dew_point: Double
    var uvi: Double
    var clouds: Int
    var visibility: Int
    var wind_speed: Double
    var wind_deg: Int
    var wind_gust: Double?
    var rain: Rain?
    var snow: Snow?
    var weather: [Weather]
    var pop: Double
    
}

struct DailyWeather: Codable {
    var dt: Int
    var sunrise: Int
    var sunset: Int
    var moonrise: Int
    var moonset: Int
    var moon_phase: Double
    var summary: String
    var temp: Temperature
    var feels_like: FeelsLike
    var pressure: Int
    var humidity: Int
    var dew_point: Double
    var wind_speed: Double
    var wind_deg: Int
    var wind_gust: Double?
    var rain: Double?
    var snow: Double?
    var weather: [Weather]
    var clouds: Int
    var pop: Double
    var uvi: Double
}

struct Temperature: Codable {
    var day: Double
    var min: Double
    var max: Double
    var night: Double
    var eve: Double
    var morn: Double
}

struct FeelsLike: Codable {
    
    var day: Double
    var night: Double
    var eve: Double
    var morn: Double
}

struct WeatherAlert: Codable {
    var sender_name: String
    var event: String
    var start: Int
    var end: Int
    var description: String
    var tags: [String]
}
