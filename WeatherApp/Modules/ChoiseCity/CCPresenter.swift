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
    var output: MWModuleInput?
    
    func viewIsReady() {
        let list = interactor.getWeatherList()
        let entity = CCEntity(isCityChoising: false,
                              cityDict: nil,
                              weatherList: list)
        interactor.updateWeatherList()
        view?.setState(entity: entity)
    }
    
    func changedSearch(text: String, lang: String) {
        if interactor.checkConnected() {
            interactor.getCityList(for: text, lang: lang)
        } else {
            let entity = CCEntity(isCityChoising: true,
                                  cityDict: nil,
                                  weatherList: nil)
            view?.setState(entity: entity)
        }
    }
    
    func changedSearch(city: CityModel) {
        let entity = CWEntity(city: city, weather: nil, background: nil)
        interactor.updateTemporary(entity: entity)
        router.showCWViewController(output: self)
    }
    
    func choisedCity(index: Int) {
        interactor.updateCurrentIndex(index: index)
        output?.needUpdateOut()
    }
    
    func deleteCity(at IndexPathRow: Int) {
        interactor.deleteCity(index: IndexPathRow)
        let list = interactor.getWeatherList()
        let entity = CCEntity(isCityChoising: false,
                              cityDict: nil,
                              weatherList: list)
        view?.setState(entity: entity)
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

