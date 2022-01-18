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
        let entity = CWEntity(city: city, weather: nil)
        interactor.addTemporary(entity: entity)
        router.showCWViewController(output: self)
    }
    
    func back() {
//        router.showMWViewController()
    }
    
    func showMWController() {
        
        router.showMWViewController()
        
    }
    
    func choisedCity(index: Int) {
        interactor.setChoisedCity(index: index)
    }
}

extension CCPresenterImp: CCInteractorOutput {
    
    func didUpdateEntity(entity: CCEntity) {
        view?.setState(entity: entity)
    }
}

extension CCPresenterImp: CCModuleInput {
    func needUpdateOut() {
        viewIsReady()
    }
}

