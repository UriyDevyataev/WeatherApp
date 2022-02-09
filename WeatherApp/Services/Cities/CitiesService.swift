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
    static var language = "lang"
}

private enum Constants {
    static var baseUrl = "http://api.geonames.org/search?"
    static var authKey = "devyataevya"
    static var ppl = "PPL"
    static var pplc = "PPLC"
    static var json = "json"
    static var cities = "cities5000"
    static var countRows = "1000"
}

protocol CitiesService {
    func receiveCities(for prefix: String,
                       lang: String,
                       success: @escaping ([CityModel]) -> Void,
                       error: @escaping (Error?) -> Void)
}

class CitiesServiceImp: CitiesService {

    private var currentTack: URLSessionTask?
    
    func receiveCities(for prefix: String, lang: String, success: @escaping ([CityModel]) -> Void, error: @escaping (Error?) -> Void) {
        
        currentTack?.cancel()
        
        let language = String(lang.split(separator: "-").first ?? "en")
        let session = URLSession.shared
        let url = prepareLoadDataRequest(for: prefix, lang: language)!
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) { data, response, err in
            guard let data = data, err == nil else {
                error(err)
                return}
            do {
                let mapped = try JSONDecoder().decode(CitiesResponse.self, from: data)
                success(mapped.geonames)
            } catch let errorData {
                error(errorData)
            }
        }
        
        if prefix == "" {
            success([CityModel]())
        } else {
            currentTack = task
            task.resume()
        }
    }
    
    private func prepareLoadDataRequest(for prefix: String, lang: String) -> URL? {
        var components = URLComponents(string: Constants.baseUrl)
        components?.queryItems = [
            URLQueryItem(name: Params.name_startsWith,value: prefix),
//            URLQueryItem(name: Params.featureCode,value: Constants.ppl),
//            URLQueryItem(name: Params.featureCode,value: Constants.pplc),
            URLQueryItem(name: Params.type, value: Constants.json),
            URLQueryItem(name: Params.cities, value: Constants.cities),
            URLQueryItem(name: Params.maxRows, value: Constants.countRows),
            URLQueryItem(name: Params.language, value: lang),
            URLQueryItem(name: Params.username, value: Constants.authKey)
        ]
        return components?.url
    }
}
