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
    let weatherListService: WeatherListService = WeatherListServiceImp()

    func requestAccessLocation() {
        locationService.requestAccess()
    }
    
    func updateEntity(_ entity: MWEntity?) {
        
        if let entity = entity {
            getWeatherFor(city: entity.city)
        } else {
            locationService.getCurrentLocalCity {[weak self] city in
                guard let self = self else {return}
                self.getWeatherFor(city: city)
            }
        }
    }
    
    private func getWeatherFor(city: CityModel){
        let coordinate = CLLocationCoordinate2D(
            latitude: Double(city.lat) ?? 0,
            longitude: Double(city.lng) ?? 0)
        weatherService.receiveWeather(for: coordinate) {[weak self] weather in
            guard let self = self else {return}
            let entity = MWEntity(city: city, weather: weather)
            self.output?.didUpdateEntity(entity: entity)
        }
    }
    
    func save(entity: MWEntity) {
        
        var newList = [MWEntity]()
        
        if let list = weatherListService.loadList() {
            
            newList = list
            var contains = false
            
            for i in 0...list.count-1 {
                if list[i].city.geonameId == entity.city.geonameId {
                    newList[i] = entity
                    contains = true
                }
            }
            
            if !contains {
                newList.append(entity)
            }
        
        } else {
            newList.append(entity)
        }
        weatherListService.save(list: newList)
    }
}

