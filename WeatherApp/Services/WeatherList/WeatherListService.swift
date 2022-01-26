//
//  WeatherListService.swift
//  WeatherApp
//
//  Created by Юрий Девятаев on 07.01.2022.
//

import Foundation

protocol WeatherListService {

    func getCountList() -> Int                      //ok
    func getList() -> [CWEntity]                    //ok
    func updateList(entity: CWEntity)               //ok
    
    func getCurrentIndex() -> Int                   //ok
    func updateCurrentIndex(value: Int)             //ok
    func getCurrentWeatherConditions() -> String    //ok
    
    func deleteEntity(for index: Int)
    
    func getTemporaryEntity() -> CWEntity?          //ok
    func setTemporary(entity: CWEntity)             //ok
    func saveTemporaryEntity()                      //ok
    
    func updateLocaly(entity: CWEntity)             //ok
}
