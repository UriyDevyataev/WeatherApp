//
//  WeatherListService.swift
//  WeatherApp
//
//  Created by Юрий Девятаев on 07.01.2022.
//

import Foundation

protocol WeatherListService {

    func getCountList() -> Int
    func getList() -> [CWEntity]?
    func getEntity(for index: Int) -> CWEntity?
    func getTemporaryEntity() -> CWEntity?
    func getChoisedEntityIndex() -> Int

    func updateTemporary(entity: CWEntity)
    func saveTemporaryEntity()
    func updateLocaly(entity: CWEntity)
    func updateList(entity: CWEntity)
    func delete(index: Int)
    func setChoisedEntity(index: Int)
    
}
