//
//  WeatherListServiceImp.swift
//  WeatherApp
//
//  Created by Юрий Девятаев on 07.01.2022.
//

import Foundation

final class WeatherListServiceImp: WeatherListService {
    
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
    
    func getList() -> [CWEntity] {
        guard let listWeather = listWeather else {
            return [CWEntity]()
        }
        return listWeather
    }
    
    func getCurrentIndex() -> Int {
        choisedEntityIndex
    }
    
    func getCurrentWeatherConditions() -> String {
        guard let entity = listWeather?[choisedEntityIndex]
        else {return ""}
        guard let string = entity.weather?.current.weather[0].icon
        else {return ""}
        return string
    }
    
    func getTemporaryEntity() -> CWEntity? {
        return temporaryEntity
    }
    
    func setTemporary(entity: CWEntity) {
        temporaryEntity = entity
    }
    
    func saveTemporaryEntity() {
        guard let entity = temporaryEntity else {return}
        temporaryEntity = nil
        updateList(entity: entity)
    }
    
    func updateLocaly(entity: CWEntity) {
        if let _ = listWeather {
            listWeather?[0] = entity
        } else {
            listWeather = [entity]
        }
        saveListToDefault(list: listWeather)
    }
    
    func updateCurrentIndex(value: Int) {
        let count = getCountList()
        if value < count {
            choisedEntityIndex = value
        }        
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
                        newList[i].background = entity.background
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
    
    func deleteEntity(for index: Int) {
        let count = getCountList()
        if index != 0, index < count {
            listWeather?.remove(at: index)
        }
        saveListToDefault(list: listWeather)
    }
    
    private func loadList() {
        if listWeather == nil {
            listWeather = loadListFromDefault()
        }
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
