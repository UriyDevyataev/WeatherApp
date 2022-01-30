//
//  LocationServiceImp.swift
//  WeatherApp
//
//  Created by Юрий Девятаев on 02.01.2022.
//

import Foundation
import CoreLocation

protocol LocationService {
    
    func getCurrentLocalCity(completion: @escaping(CityModel) -> Void)
}

class LocationServiceImp: LocationService {
    
    let locationManager = CLLocationManager()

    func getCurrentLocalCity(completion: @escaping(CityModel) -> Void) {
        
        guard let currentCoordinate = getCurrentLocation()
        else {return}
        
        let location = CLLocation(latitude: currentCoordinate.latitude,
                                  longitude: currentCoordinate.longitude)
        
        getPlaceFrom(location: location) { place, error in
            guard let place = place?[0], error == nil else {return}

            let city = CityModel(adminCode1: "",
                                 lng: String(currentCoordinate.longitude),
                                 geonameId: 0,
                                 toponymName:"",
                                 countryId: "",
                                 fcl: "",
                                 population: 1,
                                 countryCode: place.isoCountryCode ?? "",
                                 name: place.locality ?? "",
                                 fclName: "",
                                 countryName: place.country ?? "",
                                 fcodeName: "",
                                 adminName1: "",
                                 lat: String(currentCoordinate.latitude),
                                 fcode: "")
            completion(city)
        }
    }
    
    func getCurrentLocation() -> CLLocationCoordinate2D? {
        locationManager.startUpdatingLocation()
        guard let loc = locationManager.location?.coordinate else {return nil}
        locationManager.stopUpdatingHeading()
        return CLLocationCoordinate2D(latitude: loc.latitude,
                                      longitude: loc.longitude)
    }
    
    private func getPlaceFrom(location: CLLocation, completion: @escaping ([CLPlacemark]?, Error?) -> Void) {
        CLGeocoder().reverseGeocodeLocation(location) { place, error in
            completion(place, error)
        }
    }
}


