//
//  WeatherListService.swift
//  WeatherApp
//
//  Created by Юрий Девятаев on 07.01.2022.
//

import Foundation

protocol WeatherListService {
    func loadList() -> [MWEntity]?
//    func save(list: [MWEntity])
    
//    func add(entity: MWEntity)
    func updateLocaly(entity: MWEntity)
    func updateList(entity: MWEntity)
    func delete(index: Int)
}
