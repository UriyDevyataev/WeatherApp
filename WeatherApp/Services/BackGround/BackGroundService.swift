//
//  BackGroundService.swift
//  WeatherApp
//
//  Created by Юрий Девятаев on 18.01.2022.
//

import Foundation

protocol BackGroundService {
    
    func configFor(condition: String) -> Background
}
