//
//  MWEntity.swift
//  WeatherApp
//
//  Created by Юрий Девятаев on 02.01.2022.
//

import Foundation

struct MWEntity: Codable{
    
    let city: CityModel
    let weather: WeatherResponse?
}
