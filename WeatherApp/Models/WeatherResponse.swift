//
//  WeatherResponse.swift
//  WeatherApp
//
//  Created by Юрий Девятаев on 02.01.2022.
//

struct WeatherResponse: Codable{
    let lat: Double
    let lon: Double
    let timezone: String
    let timezone_offset: Int
    let current: CurrentWeather
    let hourly: [HourlyWeather]
    let daily: [DailyWeather]
    let alerts: [Alerts]?
}

struct CurrentWeather: Codable{
    let dt: Int
    let sunrise: Int
    let sunset: Int
    let temp: Double
    let feels_like: Double
    let pressure: Int
    let humidity: Int
    let dew_point: Double
    let clouds: Int
    let uvi: Double
    let visibility: Int
    let wind_speed: Double
    let wind_gust: Double?
    let wind_deg: Double
    let rain: RainOneHour?
    let snow: SnowOneHour?
    let weather: [Weather]
}

struct HourlyWeather: Codable{
    let dt: Int
    let temp: Double
    let feels_like: Double
    let pressure: Int
    let humidity: Int
    let dew_point: Double
    let uvi: Double
    let clouds: Int
    let visibility: Int
    let wind_speed: Double
    let wind_gust: Double?
    let wind_deg: Double
    let pop: Double
    let rain: RainOneHour?
    let snow: SnowOneHour?
    var weather: [Weather]
}

struct RainOneHour: Codable{
    let h: Int?
}

struct SnowOneHour: Codable{
    let h: Int?
}

struct DailyWeather: Codable{
    let dt: Int
    let sunrise: Int
    let sunset: Int
    let moonrise: Int
    let moonset: Int
    let moon_phase: Double
    let temp: Temp
    let feels_like: Feels_like
    let pressure: Int
    let humidity: Int
    let dew_point: Double
    let wind_speed: Double
    let wind_gust: Double?
    let wind_deg: Int
    let clouds: Int
    let uvi: Double
    let pop: Double
    let rain: Double?
    let snow: Double?
    let weather: [Weather]
}
    
struct Temp: Codable{
    let morn: Double
    let day: Double
    let eve: Double
    let night: Double
    let min: Double
    let max: Double
}
 
struct Feels_like: Codable{
    let morn: Double
    let day: Double
    let eve: Double
    let night: Double
}

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    var icon: String
}

struct Alerts: Codable {
    let sender_name: String
    let event: String
    let start: Int
    let end: Int
    let description: String
    let tags: [String]
}
