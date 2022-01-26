//
//  CWInteractor.swift
//  WeatherApp
//
//  Created by Юрий Девятаев on 12.01.2022.
//

import Foundation
import CoreLocation

class CWInteractorImp: CWInteractorInput {
    
    weak var output: CWInteractorOutput?
    
    let weatherService: WeatherService = WeatherServiceImp()
    let weatherListService: WeatherListService = WeatherListServiceImp.shared
    let locationService: LocationService = LocationServiceImp()
    let backGroundService: BackGroundService = BackGroundServiceImp()
    
    func loadEntity(atIndex: Int?) -> CWEntity? {
        guard let atIndex = atIndex else {
            return weatherListService.getTemporaryEntity()
        }
        let list = weatherListService.getList()
        return list[atIndex]
    }
    
    func updateEntity(_ entity: CWEntity) {
        
        let localEntity = weatherListService.getList().first
        
        if localEntity?.city.geonameId == entity.city.geonameId {
            updateLocalEntityCW()
        } else {
            var newEntity = entity
            let location = CLLocationCoordinate2D(
                latitude: Double(entity.city.lat) ?? 0,
                longitude: Double(entity.city.lng) ?? 0)
            weatherService.receiveWeather(for: location) {[weak self] weather in
                
                guard let self = self else {return}
                
                let condition = weather?.current.weather[0].icon ?? ""
                let background = self.backGroundService.configFor(condition: condition)
                
                newEntity.weather = weather
                newEntity.background = background
                
                self.weatherListService.updateList(entity: newEntity)
                self.output?.didUpdateEntity(entity: newEntity)
            }
        }
    }
    
    private func updateLocalEntityCW() {
        
        locationService.getCurrentLocalCity { [weak self] city in
            guard let self = self else {return}
            let location = CLLocationCoordinate2D(
                latitude: Double(city.lat) ?? 0,
                longitude: Double(city.lng) ?? 0)
            self.weatherService.receiveWeather(for: location) { weather in
                
                let condition = weather?.current.weather[0].icon ?? ""
                let background = self.backGroundService.configFor(condition: condition)
                
                let entityCW = CWEntity(city: city,
                                        weather: weather,
                                        background: background)
                
                self.weatherListService.updateLocaly(entity: entityCW)
                self.output?.didUpdateEntity(entity: entityCW)
            }
        }
    }
    
    func addTemporaryEntity() {
        weatherListService.saveTemporaryEntity()
    }
}
