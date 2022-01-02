//
//  WeatherResponse.swift
//  WeatherApp
//
//  Created by Юрий Девятаев on 02.01.2022.
//

struct WeatherResponse: Codable{
    let timezone: String
    let current: CurrentWeather
    let daily: [DayWeather]
    
}

struct CurrentWeather: Codable{
    let temp: Double
    let feels_like: Double
    let humidity: Int
    let wind_speed: Double
}

struct DayWeather: Codable{
    let dt: Int
    let temp: Temp
    let feels_like: Feels_like
    let humidity: Int
    let wind_speed: Double
}
    
struct Temp: Codable{
    let day: Double
    let min: Double
    let max: Double
    let night: Double
    let eve: Double
    let morn: Double
}
 
struct Feels_like: Codable{
    let day: Double
    let night: Double
    let eve: Double
    let morn: Double
}
