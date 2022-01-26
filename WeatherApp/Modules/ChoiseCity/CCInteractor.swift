//
//  CCInteractor.swift
//  WeatherApp
//
//  Created by Юрий Девятаев on 05.01.2022.
//

import Foundation
import CoreLocation

final class CCInteractorImp: CCInteractorInput {
    
    weak var output: CCInteractorOutput?

    let weatherService: WeatherService = WeatherServiceImp()
    let weatherListService: WeatherListService = WeatherListServiceImp.shared
    let cityService = CitiesServiceImp()
    let backGroundService: BackGroundService = BackGroundServiceImp()
    
    func getWeatherList() -> [CWEntity] {
        return weatherListService.getList()
    }
    
    func updateTemporary(entity: CWEntity) {
        weatherListService.setTemporary(entity: entity)
    }
     
    func getCityList(for searchText: String) {
        
        self.cityService.receiveCities(for: searchText) { cities in
            var dict = [String: CityModel]()
            cities.forEach { city in
                
                if dict[city.name] == nil {
                    dict[city.name] = city
                } else {
                    guard let oldCity = dict[city.name] else {return}
                    var newKey = "\(oldCity.name), \(oldCity.adminName1), \(oldCity.countryName)"
                    if newKey.last == " " {
                        newKey.removeLast(2)
                    }
                    dict[newKey] = oldCity
                    dict.removeValue(forKey: oldCity.name)
                    
                    newKey = "\(city.name), \(city.adminName1), \(city.countryName)"
                    if newKey.last == " " {
                        newKey.removeLast(2)
                    }
                    dict[newKey] = city
                }
            }
                
            let entity = CCEntity(isCityChoising: true,
                                  cityDict: dict,
                                  weatherList: nil)
            self.output?.didUpdateEntity(entity: entity)
        }
    }
    
    func updateCurrentIndex(index: Int) {
        weatherListService.updateCurrentIndex(value: index)
    }
    
    func updateWeatherList() {
        let list = weatherListService.getList()
        let group = DispatchGroup()
        
        list.forEach { entityCW in
            var newEntity = entityCW
            let location = CLLocationCoordinate2D(
                latitude: Double(entityCW.city.lat) ?? 0,
                longitude: Double(entityCW.city.lng) ?? 0)
            
            group.enter()
            weatherService.receiveWeather(for: location) {[weak self] weather in
                guard let self = self else {return}
                
                let condition = weather?.current.weather[0].icon ?? ""
                let background = self.backGroundService.configFor(condition: condition)
                
                newEntity.weather = weather
                newEntity.background = background
                
                self.weatherListService.updateList(entity: newEntity)
                group.leave()
            }
        }
        
        group.notify(queue: .global(qos: .userInteractive)) {
            print("notify")
            let list = self.weatherListService.getList()
            let entity = CCEntity(isCityChoising: false,
                                  cityDict: nil,
                                  weatherList: list)
            self.output?.didUpdateEntity(entity: entity)
        }
    }
    
    func deleteEntity(index: Int) {
        weatherListService.deleteEntity(for: index)
    }
}
