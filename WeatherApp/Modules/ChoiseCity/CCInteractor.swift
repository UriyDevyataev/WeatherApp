//
//  CCInteractor.swift
//  WeatherApp
//
//  Created by Юрий Девятаев on 05.01.2022.
//

import Foundation

final class CCInteractorImp: CCInteractorInput {
        
    weak var output: CCInteractorOutput?

    let weatherListService: WeatherListService = WeatherListServiceImp.shared
    let cityService = CitiesServiceImp()
    
    func getWeatherList() -> [CWEntity]? {
        return weatherListService.getList()
    }
    
    func addTemporary(entity: CWEntity) {
        weatherListService.updateTemporary(entity: entity)
    }
     
    func reloadCityList(for searchText: String) {
    
        cityService.receiveCities(for: searchText) { cities in
            
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
            
            let entity = CCEntity(isCityChoising: true, cityDict: dict, weatherList: [CWEntity]())
            self.output?.didUpdateEntity(entity: entity)
        }
    }
    
    func setChoisedCity(index: Int) {
        weatherListService.setChoisedEntity(index: index)
    }
}
