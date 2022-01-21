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
    
    func loadEntity(atIndex: Int?) -> CWEntity? {
        guard let atIndex = atIndex else {
            return weatherListService.getTemporaryEntity()
        }
        return weatherListService.getEntity(for: atIndex)
    }
    
    func updateEntity(_ entity: CWEntity) {
        var newEntity = entity
        let location = CLLocationCoordinate2D(
            latitude: Double(entity.city.lat) ?? 0,
            longitude: Double(entity.city.lng) ?? 0)
        weatherService.receiveWeather(for: location) {[weak self] weather in
            guard let self = self else {return}
            newEntity.weather = weather
            self.weatherListService.updateList(entity: newEntity)
            self.output?.didUpdateEntity(entity: newEntity)
        }
    }
    
    func addTemporaryEntity() {
        weatherListService.saveTemporaryEntity()
    }
}
