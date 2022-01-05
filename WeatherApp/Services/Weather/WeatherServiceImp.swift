//
//  WeatherServiceImp.swift
//  WeatherApp
//
//  Created by Юрий Девятаев on 02.01.2022.
//

import Foundation

private enum Params{
    static let auth = "appid"
    static let exclude = "exclude"
    static let latitude = "lat"
    static let longitude = "lon"
    static let units = "units"
}

private enum Periods{
    static let current = "current"
    static let minutely = "minutely"
    static let hourly = "hourly"
    static let daily = "daily"
    static let alerts = "alerts"
}

private enum Constants {
    static var apiKey = "6519f53be1ceaac0b0a6af0aab58a215"
    static var baseUrl = "https://api.openweathermap.org/data/2.5/onecall"
    static var metric = "metric"
}

class WeatherServiceImp: WeatherService {
    
    func receiveWeather(for location: Coordinate, completion: @escaping (WeatherResponse) -> Void) {
        
        let session = URLSession.shared
        let request = URLRequest(url: prepareLoadDataRequest(forLocal: location)!)
//        print(request)
        let task = session.dataTask(with: request) { data, response, error in
            guard let data = data else {return}
            do {
                let mapped = try JSONDecoder().decode(WeatherResponse.self, from: data)
//                print(String(data: data, encoding: .utf8))
//                print(mapped)
                completion(mapped)
            } catch let error {
                print(error)
            }
        }
        task.resume()
    }
    
    private func prepareLoadDataRequest(forLocal: Coordinate) -> URL? {
        var components = URLComponents(string: Constants.baseUrl)
        components?.queryItems = [
            URLQueryItem(name: Params.latitude,value: String(forLocal.lat)),
            URLQueryItem(name: Params.longitude,value: String(forLocal.lon)),
            URLQueryItem(name: Params.exclude, value: Periods.minutely),
            URLQueryItem(name: Params.units, value: Constants.metric),
            URLQueryItem(name: Params.auth, value: Constants.apiKey)
        ]
        return components?.url
    }
}
