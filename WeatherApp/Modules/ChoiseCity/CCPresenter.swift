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
        
    }
    
    func changedCity(text: String) {
        interactor.reloadCityList(for: text)
    }
    
    func choisedCity(city: CityModel) {
        router.showMWViewController(with: city)
    }
    
    func back() {
//        router.showMWViewController()
    }
}

extension CCPresenterImp: CCInteractorOutput {
    
    func didUpdateEntity(entity: CCEntity) {
        view?.setState(entity: entity)
    }
}

