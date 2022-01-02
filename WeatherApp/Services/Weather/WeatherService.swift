//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Юрий Девятаев on 02.01.2022.
//

import Foundation

protocol WeatherService {
    func receiveWeather(for location: Coordinate, completion: @escaping (WeatherResponse) -> Void)
}
