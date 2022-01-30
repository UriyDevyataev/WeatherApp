//
//  CCEntity.swift
//  WeatherApp
//
//  Created by Юрий Девятаев on 05.01.2022.
//

import Foundation

struct CCEntity {
    var isCityChoising: Bool
    var cityDict: [String: CityModel]?
    var weatherList: [CWEntity]?
}
