//
//  WeatherListService.swift
//  WeatherApp
//
//  Created by Юрий Девятаев on 07.01.2022.
//

import Foundation

protocol WeatherListService {
    func save(list: [MWEntity])
    func loadList() -> [MWEntity]?
}
