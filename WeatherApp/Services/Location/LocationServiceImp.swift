//
//  LocationServiceImp.swift
//  WeatherApp
//
//  Created by Юрий Девятаев on 02.01.2022.
//

import Foundation
import CoreLocation

class LocationServiceImp: LocationService{
   
    let locationManager = CLLocationManager()
    
    func requestAccess() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
    }
    
    func getCurrentLocalCity(completion: @escaping(CityModel) -> Void) {
        guard let currentCoordinate = getCurrentLocation()
        else {return}
        
        let location = CLLocation(latitude: currentCoordinate.lat,
                                  longitude: currentCoordinate.lon)

        getPlaceFrom(location: location) { place, error in
            guard let place = place?[0], error == nil else {return}

            let coordinate = Coordinate(lon: location.coordinate.longitude,
                                        lat: location.coordinate.latitude)

            let city = CityModel(id: 0,
                                 name: place.locality ?? "",
                                 state: "",
                                 country: place.country ?? "",
                                 coord: coordinate)
            completion(city)
        }
    }
    
    func getCurrentLocation() -> Coordinate? {
        locationManager.startUpdatingLocation()
        guard let loc = locationManager.location?.coordinate else {return nil}
        locationManager.stopUpdatingHeading()
        return Coordinate(lon: loc.longitude, lat: loc.latitude)
    }
    
    private func getPlaceFrom(location: CLLocation, completion: @escaping ([CLPlacemark]?, Error?) -> Void) {
        CLGeocoder().reverseGeocodeLocation(location) { place, error in
            completion(place, error)
        }
    }
}
