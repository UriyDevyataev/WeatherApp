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
    let locationManager = CLLocationManager()
    
    var weatherService: WeatherService!
    var locationService: LocationService!
    var weatherListService: WeatherListService!
    var backGroundService: BackGroundService!
    
    func requestAccessLocation() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
    }
    
    func getEntity() -> MWEntity {
        let count = weatherListService.getCountList()
        let index = weatherListService.getCurrentIndex()
        if count == 0 {
            createLocalEntityCW()
        }
        return MWEntity(count: count, choisedIndex: index)
    }
    
    func updateCurrentIndex(index: Int) {
        weatherListService.updateCurrentIndex(value: index)
    }
    
    func getNewBackGround() -> Background {
        let condition = weatherListService.getCurrentWeatherConditions()
        let backGround = backGroundService.configFor(condition: condition)
        return backGround
    }
    
    private func createLocalEntityCW() {
        
        locationService.getCurrentLocalCity { [weak self] city in
            guard let self = self else {return}
            let location = CLLocationCoordinate2D(
                latitude: Double(city.lat) ?? 0,
                longitude: Double(city.lng) ?? 0)
            self.weatherService.receiveWeather(for: location) {weather in
                
                let condition = weather?.current.weather[0].icon ?? ""
                let background = self.backGroundService.configFor(condition: condition)
                
                let entityCW = CWEntity(city: city,
                                        weather: weather,
                                        background: background)
                
                self.weatherListService.addtoList(entity: entityCW)
                
                let entityMW = MWEntity(count: 1, choisedIndex: 0)
                self.output?.didUpdateEntity(entity: entityMW)
            } error: { _ in }
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


