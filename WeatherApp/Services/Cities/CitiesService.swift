//
//  CitiesService.swift
//  WeatherApp
//
//  Created by Юрий Девятаев on 06.01.2022.
//

import Foundation

protocol CitiesService {
    
    func receiveCities(for prefix: String, completion: @escaping ([CityModel]) -> Void)
}
