//
//  WeatherListServiceImp.swift
//  WeatherApp
//
//  Created by Юрий Девятаев on 07.01.2022.
//

import Foundation

final class WeatherListServiceImp: WeatherListService {

    let storage: KeyValueStorage = SharedStorage()
    
    private let keyList = "weather_list"
    
    func save(list: [MWEntity]) {
        
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(list) {
            storage.setValue(key: keyList, value: data)
        }
    }
    
    func loadList() -> [MWEntity]? {
        let decoder = JSONDecoder()
        guard let data: Data = storage
                .getValue(key: keyList) else {return nil}
        guard let list = try? decoder.decode(
            [MWEntity].self, from: data) else {return nil}
        return list
    }
}
