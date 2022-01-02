//
//  CityModel.swift
//  WeatherApp
//
//  Created by Юрий Девятаев on 02.01.2022.
//

struct CityModel: Codable{
    let id: Double
    let name: String
    let state: String
    let country: String
    let coord: Coordinate
}

struct Coordinate: Codable{
    let lon: Double
    let lat: Double
}
