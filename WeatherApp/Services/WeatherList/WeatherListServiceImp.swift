//
//  WeatherListServiceImp.swift
//  WeatherApp
//
//  Created by Юрий Девятаев on 07.01.2022.
//

import Foundation

final class WeatherListServiceImp: WeatherListService {
    
    func setChoisedEntity(index: Int) {
        choisedEntityIndex = index
    }
    
    func getChoisedEntityIndex() -> Int {
        choisedEntityIndex
    }
    

    static var shared: WeatherListService = WeatherListServiceImp()
    
    private var listWeather: [CWEntity]?
    private var temporaryEntity: CWEntity?
    private var choisedEntityIndex: Int = 0
    private let storageDefault: KeyValueStorage = SharedStorage()
    private let keyList = "weather_list"
    
    func getCountList() -> Int {
        loadList()
        guard let count = listWeather?.count else {return 0}
        return count
    }
    
    func getEntity(for index: Int) -> CWEntity? {
        return listWeather?[index]
    }
    
    func getList() -> [CWEntity]? {
        return listWeather
    }
        
    private func loadList() {
        if listWeather == nil {
            listWeather = loadListFromDefault()
        }
    }
    
    func updateTemporary(entity: CWEntity) {
        temporaryEntity = entity
    }
    
    func getTemporaryEntity() -> CWEntity? {
        return temporaryEntity
    }
    
    func saveTemporaryEntity() {
        guard let entity = temporaryEntity else {return}
        temporaryEntity = nil
        updateList(entity: entity)
    }
    
    func updateList(entity: CWEntity) {
        
        if let _ = temporaryEntity {
            
            temporaryEntity = entity
            
        } else {
            
            var newList = [CWEntity]()
            
            if let list = listWeather {
                
                newList = list
                var contains = false
                
                for i in 0...list.count-1 {
                    if list[i].city.geonameId == entity.city.geonameId {
                        newList[i].weather = entity.weather
                        contains = true
                    }
                }
                
                if !contains {
                    newList.append(entity)
                }
                
            } else {
                newList = [entity]
            }
            
            listWeather = newList
            saveListToDefault(list: listWeather)
        }
    }
    
    func updateLocaly(entity: CWEntity) {
        if let _ = listWeather {
            listWeather?[0] = entity
        } else {
            listWeather = [entity]
        }
        saveListToDefault(list: listWeather)
    }
    
    func delete(index: Int) {
        if index != 0 {
            listWeather?.remove(at: index)
        }
        saveListToDefault(list: listWeather)
    }
    
    private func saveListToDefault(list: [CWEntity]?) {
        guard let list = listWeather else {return}
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(list) {
            storageDefault.setValue(key: keyList, value: data)
        }
    }
    
    private func loadListFromDefault() -> [CWEntity]? {
        let decoder = JSONDecoder()
        guard let data: Data = storageDefault
                .getValue(key: keyList) else {return nil}
        guard let list = try? decoder.decode(
            [CWEntity].self, from: data) else {return nil}
        return list
    }
}
