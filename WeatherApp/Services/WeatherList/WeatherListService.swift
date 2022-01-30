//
//  WeatherListService.swift
//  WeatherApp
//
//  Created by Юрий Девятаев on 07.01.2022.
//

import Foundation

protocol WeatherListService {

    func addtoList(entity: CWEntity)
    func updateList(entity: CWEntity, index: Int)
    func deleteFromList(for index: Int)
    
    func getList() -> [CWEntity]
    func getCountList() -> Int
    
    func getCurrentIndex() -> Int
    func updateCurrentIndex(value: Int)
    func getCurrentWeatherConditions() -> String
    
    func setTemporary(entity: CWEntity)
    func getTemporaryEntity() -> CWEntity?
}
