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
    
    var weatherService: WeatherService!
    var weatherListService: WeatherListService!
    var locationService: LocationService!
    var backGroundService: BackGroundService!
    
    func loadEntity(atIndex: Int?) -> CWEntity? {
        guard let atIndex = atIndex else {
            return weatherListService.getTemporaryEntity()
        }
        let list = weatherListService.getList()
        return list[atIndex]
    }
    
    func updateEntity(_ entity: CWEntity, index: Int?) {
        
        if index == 0 {
            updateLocalEntityCW()
        } else {
            
            let location = CLLocationCoordinate2D(
                latitude: Double(entity.city.lat) ?? 0,
                longitude: Double(entity.city.lng) ?? 0)

            weatherService.receiveWeather(for: location) {[weak self] weather in
                guard let self = self else {return}
                
                let condition = weather?.current.weather[0].icon ?? ""
                let background = self.backGroundService.configFor(condition: condition)
                
                let entityCW = CWEntity(city: entity.city,
                                      weather: weather,
                                      background: background)
                
                guard let index = index else {
                    self.weatherListService.setTemporary(entity: entityCW)
                    self.output?.didUpdateEntity(entity: entityCW)
                    return
                }
                
                self.weatherListService.updateList(entity: entityCW, index: index)
                self.output?.didUpdateEntity(entity: entityCW)
            } error: {error in
                print(error)
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
                
                self.weatherListService.updateList(entity: entityCW, index: 0)
                self.output?.didUpdateEntity(entity: entityCW)
            } error: { _ in }
        }
    }
    
    func addTemporaryEntity() {
        guard let entityCW = weatherListService.getTemporaryEntity() else {
            return
        }
        weatherListService.addtoList(entity: entityCW)
    }
}
