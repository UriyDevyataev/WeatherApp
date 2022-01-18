//
//  CCEntity.swift
//  WeatherApp
//
//  Created by Юрий Девятаев on 05.01.2022.
//

import Foundation

struct CCEntity {
    var isCityChoising: Bool
    let cityDict: [String: CityModel]
    let weatherList: [CWEntity]
}
