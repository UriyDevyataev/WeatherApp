//
//  CityResponse.swift
//  WeatherApp
//
//  Created by Юрий Девятаев on 02.01.2022.
//

struct CitiesResponse: Codable {
    let totalResultsCount: Int?
    let geonames: [CityModel]
}

struct CityModel: Codable {
    let adminCode1: String?
    let lng: String
    let geonameId: Int
    let toponymName: String
    let countryId: String
    let fcl: String
    let population: Int
    let countryCode: String
    let name: String
    let fclName: String
    let countryName: String
    let fcodeName: String
    let adminName1: String
    let lat: String
    let fcode: String
}

//struct CityModel: Codable{
//    let id: Double
//    let name: String
//    let state: String
//    let country: String
//    let coord: Coordinate
//}
//
//struct Coordinate: Codable{
//    let lon: Double
//    let lat: Double
//}
