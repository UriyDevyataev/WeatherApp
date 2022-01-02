//
//  MWInteractor.swift
//  WeatherApp
//
//  Created by Юрий Девятаев on 02.01.2022.
//

final class MWInteractorImp: MWInteractorInput {
    
    weak var output: MWInteractorOutput?
    
    let weatherService: WeatherService = WeatherServiceImp()
    let locationService: LocationService = LocationServiceImp()
    
    func requestAccessLocation() {
        locationService.requestAccess()
    }
    
    func updateEntityFor(location: Coordinate?) {
        
        locationService.getCurrentLocalCity {[weak self] city in
            guard let self = self else {return}
            self.getWeatherFor(city: city)
        }
    }
    
    private func getWeatherFor(city: CityModel){
        weatherService.receiveWeather(for: city.coord) {[weak self] weather in
            guard let self = self else {return}
            let entity = MWEntity(city: city, weather: weather)
            self.output?.didUpdateEntity(entity: entity)
        }
    }
}

