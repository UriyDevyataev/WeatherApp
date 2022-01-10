//
//  WeatherListServiceImp.swift
//  WeatherApp
//
//  Created by Юрий Девятаев on 07.01.2022.
//

import Foundation

final class WeatherListServiceImp: WeatherListService {
   
    static var shared: WeatherListService = WeatherListServiceImp()
    
    private var listWeather: [MWEntity]?
    private let storageDefault: KeyValueStorage = SharedStorage()
    private let keyList = "weather_list"
    
    func loadList() -> [MWEntity]? {
        if listWeather == nil {
            listWeather = loadListFromDefault()
        }
        return listWeather
    }
    
    func updateList(entity: MWEntity) {
        
        var newList = [MWEntity]()
        
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
    
    func updateLocaly(entity: MWEntity) {
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
    
    private func saveListToDefault(list: [MWEntity]?) {
        guard let list = listWeather else {return}
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(list) {
            storageDefault.setValue(key: keyList, value: data)
        }
    }
    
    private func loadListFromDefault() -> [MWEntity]? {
        let decoder = JSONDecoder()
        guard let data: Data = storageDefault
                .getValue(key: keyList) else {return nil}
        guard let list = try? decoder.decode(
            [MWEntity].self, from: data) else {return nil}
        return list
    }
}
