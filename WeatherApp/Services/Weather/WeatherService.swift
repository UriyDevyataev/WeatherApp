//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Юрий Девятаев on 02.01.2022.
//

import Foundation
import CoreLocation

protocol WeatherService {
    func receiveWeather(for location: CLLocationCoordinate2D, completion: @escaping (WeatherResponse) -> Void)
}
