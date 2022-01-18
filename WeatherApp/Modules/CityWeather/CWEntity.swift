//
//  CWEntity.swift
//  WeatherApp
//
//  Created by Юрий Девятаев on 12.01.2022.
//

import Foundation


struct CWEntity: Codable{
    
    let city: CityModel
    var weather: WeatherResponse?
}
