//
//  MWInteractor.swift
//  WeatherApp
//
//  Created by Юрий Девятаев on 02.01.2022.
//

import CoreLocation
import UIKit
import SnapKit
import Rswift

final class MWInteractorImp: MWInteractorInput {

    weak var output: MWInteractorOutput?
    
    let weatherService: WeatherService = WeatherServiceImp()
    let locationService: LocationService = LocationServiceImp()
    let weatherListService: WeatherListService = WeatherListServiceImp.shared

    func requestAccessLocation() {
        locationService.requestAccess()
    }
    
    func loadEntity(atIndex: Int) {
        let list = weatherListService.loadList()
        var entity = list?[atIndex]
        if let entity = entity {
            output?.didUpdateEntity(entity: entity)
        }
        if atIndex == 0 {
            entity = nil
        }
        updateEntity(entity)
    }
    
    func updateEntity(_ entity: MWEntity?) {
        if let entity = entity {
            getWeatherFor(city: entity.city)
        } else {
            updateLocalyEntity()
        }
    }
    
    private func updateLocalyEntity() {
        locationService.getCurrentLocalCity {[weak self] city in
            guard let self = self else {return}
            let entity = MWEntity(city: city, weather: nil)
            self.weatherListService.updateLocaly(entity: entity)
            self.getWeatherFor(city: entity.city)
        }
    }
    
    private func getWeatherFor(city: CityModel) {
        let coordinate = CLLocationCoordinate2D(
            latitude: Double(city.lat) ?? 0,
            longitude: Double(city.lng) ?? 0)
        weatherService.receiveWeather(for: coordinate) {[weak self] weather in
            guard let self = self else {return}
            let entity = MWEntity(city: city, weather: weather)
            self.weatherListService.updateList(entity: entity)
            self.output?.didUpdateEntity(entity: entity)
        }
    }
    
    func addToList(entity: MWEntity) {
        weatherListService.updateList(entity: entity)
//        weatherListService.updateLocaly(entity: entity)
    }
}


