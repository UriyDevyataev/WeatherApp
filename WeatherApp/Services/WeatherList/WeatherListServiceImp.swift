//
//  WeatherListServiceImp.swift
//  WeatherApp
//
//  Created by Юрий Девятаев on 07.01.2022.
//

final class WeatherListServiceImp: WeatherListService {

    static var shared: WeatherListService = WeatherListServiceImp()
    private var listWeather: [CWEntity]?
    private var temporaryEntity: CWEntity?
    private var choisedEntityIndex: Int = 0
    private let coreDataStorage = CoreDataStorageImp()
    
//    private let storageDefault: KeyValueStorage = SharedStorage()
//    private let keyList = "weather_list"

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
        var string = ""
        if choisedEntityIndex < listWeather?.count ?? 0 {
            guard let entity = listWeather?[choisedEntityIndex] else {return ""}
            string = entity.weather?.current.weather[0].icon ?? ""
        }
        return string
    }
    
    func getTemporaryEntity() -> CWEntity? {
        return temporaryEntity
    }
    
    func setTemporary(entity: CWEntity) {
        temporaryEntity = entity
    }
        
    func updateCurrentIndex(value: Int) {
        let count = getCountList()
        if value < count {
            choisedEntityIndex = value
        }        
    }
    
    func addtoList(entity: CWEntity) {
        if let _ = listWeather {
            listWeather?.append(entity)
        } else {
            listWeather = [entity]
        }
        coreDataStorage.addToList(city: entity)
    }
    
    func updateList(entity: CWEntity, index: Int) {
        let count = getCountList()
        if index < count {
//            print("coreDataStorage: index - \(index), city - \(entity.city.name)")
            listWeather?[index] = entity
            coreDataStorage.updateList(index: index, entity: entity)
        }
    }
    
    func deleteFromList(for index: Int) {
        let count = getCountList()
        if index != 0, index < count {
            listWeather?.remove(at: index)
            coreDataStorage.deleteFromList(index: index)
        }
//        saveListToDefault(list: listWeather)
    }

    private func loadList() {
        if listWeather == nil {
//            listWeather = loadListFromDefault()
            listWeather = coreDataStorage.fetchList()
        }
    }
    
//    private func saveListToDefault(list: [CWEntity]?) {
//        guard let list = listWeather else {return}
//        let encoder = JSONEncoder()
//        if let data = try? encoder.encode(list) {
//            storageDefault.setValue(key: keyList, value: data)
//        }
//    }
//
//    private func loadListFromDefault() -> [CWEntity]? {
//        let decoder = JSONDecoder()
//        guard let data: Data = storageDefault
//                .getValue(key: keyList) else {return nil}
//        guard let list = try? decoder.decode(
//            [CWEntity].self, from: data) else {return nil}
//        return list
//    }
}
