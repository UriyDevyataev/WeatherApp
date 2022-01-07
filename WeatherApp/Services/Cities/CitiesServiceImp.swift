//
//  CitiesServiceImp.swift
//  WeatherApp
//
//  Created by Юрий Девятаев on 06.01.2022.
//

import Foundation

private enum Params{
    static let name_startsWith = "name_startsWith"
    static let featureCode = "featureCode"
    static var username = "username"
    static var type = "type"
    static var cities = "cities"
    static var maxRows = "maxRows"
}

private enum Constants {
    static var baseUrl = "http://api.geonames.org/search?"
    static var authKey = "devyataevya"
    static var ppl = "PPL"
    static var pplc = "PPLC"
    static var json = "json"
    static var cities = "cities1000"
    static var countRows = "1000"
}
class CitiesServiceImp: CitiesService {
    
    func receiveCities(for prefix: String, completion: @escaping ([CityModel]) -> Void) {
        
        let session = URLSession.shared
        let request = URLRequest(url: prepareLoadDataRequest(for: prefix)!)
        let task = session.dataTask(with: request) { data, response, error in
            guard let data = data else {return}
            do {
                let mapped = try JSONDecoder().decode(CitiesResponse.self, from: data)
//                print(String(data: data, encoding: .utf8))
//                print(mapped)
                completion(mapped.geonames)
            } catch let error {
                print(error)
            }
        }
        task.resume()
    }
    
    private func prepareLoadDataRequest(for prefix: String) -> URL? {
        var components = URLComponents(string: Constants.baseUrl)
        components?.queryItems = [
            URLQueryItem(name: Params.name_startsWith,value: prefix),
            URLQueryItem(name: Params.featureCode,value: Constants.ppl),
            URLQueryItem(name: Params.featureCode,value: Constants.pplc),
            URLQueryItem(name: Params.type, value: Constants.json),
            URLQueryItem(name: Params.cities, value: Constants.cities),
            URLQueryItem(name: Params.maxRows, value: Constants.countRows),
            URLQueryItem(name: Params.username, value: Constants.authKey)
        ]
//        print(components?.url)
        return components?.url
    }
}
