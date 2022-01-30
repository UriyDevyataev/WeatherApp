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

    var weatherService: WeatherService!
    var weatherListService: WeatherListService!
    var cityService: CitiesService!
    var backGroundService: BackGroundService!
    var connectionService: Connect!
    
    func getWeatherList() -> [CWEntity] {
        return weatherListService.getList()
    }
    
    func updateTemporary(entity: CWEntity) {
        weatherListService.setTemporary(entity: entity)
    }
    
    func checkConnected() -> Bool {
        connectionService.checkConnection()
    }
    
    func getCityList(for searchText: String, lang: String) {
        
        self.cityService.receiveCities(for: searchText, lang: lang) { cities in
            var dict = [String: CityModel]()
            cities.forEach { city in
                
                var name = "\(city.name), \(city.adminName1), \(city.countryName)"
                
                if city.name == city.adminName1 {
                    name = "\(city.name), \(city.countryName)"
                }
                
                if dict[name] == nil {
                    dict[name] = city
                }
            }
                
            let entity = CCEntity(isCityChoising: true,
                                  cityDict: dict,
                                  weatherList: nil)
            self.output?.didUpdateEntity(entity: entity)
        } error: { _ in }
    }
    
    func updateCurrentIndex(index: Int) {
        weatherListService.updateCurrentIndex(value: index)
    }
    
    func updateWeatherList() {
        let list = weatherListService.getList()
        let group = DispatchGroup()
        
        for i in 0..<list.count {
            var entityCW = list[i]
            let location = CLLocationCoordinate2D(
                latitude: Double(entityCW.city.lat) ?? 0,
                longitude: Double(entityCW.city.lng) ?? 0)
            
            group.enter()
            weatherService.receiveWeather(for: location) {[weak self] weather in
                guard let self = self else {return}
                
                let condition = weather?.current.weather[0].icon ?? ""
                let background = self.backGroundService.configFor(condition: condition)
                
                entityCW.weather = weather
                entityCW.background = background
                
                self.weatherListService.updateList(entity: entityCW, index: i)
                group.leave()
            } error: { err in
                print(err ?? "")
            }
        }
        
        group.notify(queue: .global(qos: .userInteractive)) {
            let list = self.weatherListService.getList()
            let entity = CCEntity(isCityChoising: false,
                                  cityDict: nil,
                                  weatherList: list)
            self.output?.didUpdateEntity(entity: entity)
        }
    }
    
    func deleteCity(index: Int) {
        weatherListService.deleteFromList(for: index)
    }
}
