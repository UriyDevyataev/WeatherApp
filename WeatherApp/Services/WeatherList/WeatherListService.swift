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
    
    func getCurrentEntityIndex() -> Int             //ok
    func updateCurrentEntity(index: Int)            //ok
    
    func getEntity(for index: Int) -> CWEntity?     //ok
    
    func getTemporaryEntity() -> CWEntity?          //ok
    func setTemporary(entity: CWEntity)          //ok
    func saveTemporaryEntity()                      //ok
    
    
    func getCurrentWeather() -> String
    func updateLocaly(entity: CWEntity)
    func updateList(entity: CWEntity)
    func delete(index: Int)
    
}
