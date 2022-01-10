//
//  CCPresenter.swift
//  WeatherApp
//
//  Created by Юрий Девятаев on 05.01.2022.
//

import Foundation

final class CCPresenterImp: CCPresenterInput {
    
    weak var view: CCPresenterOutput?
    var interactor: CCInteractorInput!
    var router: CCRouterImp!
    
    func viewIsReady() {
        guard let list = interactor.getWeatherList() else {return}
        let entity = CCEntity(isCityChoising: false,
                              cityDict: [String: CityModel](),
                              weatherList: list)
        view?.setState(entity: entity)
    }
    
    func changedCity(text: String) {
        if text == "" {
            guard let list = interactor.getWeatherList() else {return}
            let entity = CCEntity(isCityChoising: false,
                                  cityDict: [String: CityModel](),
                                  weatherList: list)
            view?.setState(entity: entity)
        } else {
            interactor.reloadCityList(for: text)
        }
    }
    
    func choisedCity(city: CityModel) {
        router.showMWViewController(with: city)
    }
    
    func back() {
//        router.showMWViewController()
    }
    
    func showMWController(entity: MWEntity) {
        router.showMWViewController(with: entity)
    }
}

extension CCPresenterImp: CCInteractorOutput {
    
    func didUpdateEntity(entity: CCEntity) {
        view?.setState(entity: entity)
    }
}

