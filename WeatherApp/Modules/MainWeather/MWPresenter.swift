//
//  MWPresenter.swift
//  WeatherApp
//
//  Created by Юрий Девятаев on 02.01.2022.
//

final class MWPresenterImp: MWPresenterInput {
    
    weak var view: MWPresenterOutput?
    weak var output: MWModuleOutput?
    
    var interactor: MWInteractorInput!
    var router: MWRouterInput!
    
    func viewIsReady() {
        interactor.requestAccessLocation()
        interactor.updateEntityFor(location: nil)
    }
    
    func actionGetLocalWeather() {
        interactor.updateEntityFor(location: nil)
    }
    
    func actionShowChoiseCity() {
        
    }
    
}

extension MWPresenterImp: MWInteractorOutput {
    func didUpdateEntity(entity: MWEntity) {
        view?.setState(entity: entity)
    }
}

extension MWPresenterImp: MWModuleOutput {
    func didUpdateEntityOut(entity: MWEntity) {
        view?.setState(entity: entity)
    }
}
