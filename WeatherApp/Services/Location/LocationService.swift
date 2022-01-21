//
//  LocationService.swift
//  WeatherApp
//
//  Created by Юрий Девятаев on 02.01.2022.
//

import Foundation
import CoreLocation

protocol LocationService {
    
    func getCurrentLocalCity(completion: @escaping(CityModel) -> Void)
//    func getCurrentLocation() -> Coordinate?
}

