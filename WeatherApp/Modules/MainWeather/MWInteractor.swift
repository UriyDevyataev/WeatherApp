//
//  MWInteractor.swift
//  WeatherApp
//
//  Created by Юрий Девятаев on 02.01.2022.
//

import CoreLocation
import UIKit
import Rswift

final class MWInteractorImp: NSObject, MWInteractorInput {
    
    weak var output: MWInteractorOutput?
    
    let weatherService: WeatherService = WeatherServiceImp()
    let locationService: LocationService = LocationServiceImp()
    let locationManager = CLLocationManager()
    let weatherListService: WeatherListService = WeatherListServiceImp.shared
    let backGroundService: BackGroundService = BackGroundServiceImp()
    
    func requestAccessLocation() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
    }
    
    func getEntity() -> MWEntity {
        var count = weatherListService.getCountList()
        var index = 0
        
        if count == 0 {
            count = 1
            createLocalEntityCW()
        } else {
            index = weatherListService.getCurrentEntityIndex()
        }
        return MWEntity(count: count, choisedIndex: index)
    }
    
    func updateCurrentIndex(index: Int) {
        weatherListService.updateCurrentEntity(index: index)
    }
    
    func getNewBackGround() -> Background {
        let condition = weatherListService.getCurrentWeather()
        let backGround = backGroundService.configFor(condition: condition)
        return backGround
    }
    
    private func createLocalEntityCW() {
        
        locationService.getCurrentLocalCity { [weak self] city in
            guard let self = self else {return}
            let location = CLLocationCoordinate2D(
                latitude: Double(city.lat) ?? 0,
                longitude: Double(city.lng) ?? 0)
            self.weatherService.receiveWeather(for: location) { weather in
                let entityCW = CWEntity(city: city, weather: weather)
                self.weatherListService.updateLocaly(entity: entityCW)
                let entityMW = MWEntity(count: 1, choisedIndex: 0)
                self.output?.didUpdateEntity(entity: entityMW)
            }
        }
    }
}

extension MWInteractorImp: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedWhenInUse ||
            manager.authorizationStatus == .authorizedAlways {
            output?.didChangeAuthorizationLocation()
        }
    }
}


