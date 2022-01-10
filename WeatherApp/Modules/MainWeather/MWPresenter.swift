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
    
    func viewIsReady(with entity: MWEntity?) {
        interactor.requestAccessLocation()
        
        if let _ = entity?.city {
            interactor.updateEntity(entity)
        } else {
            interactor.loadEntity(atIndex: 0)
        }
    }
    
    func actionGetLocalWeather() {
        interactor.loadEntity(atIndex: 0)
    }
    
    func actionShowChoiseCity() {
        router.showCCViewController()
    }
    
    func actionAdd(entity: MWEntity) {
        interactor.addToList(entity: entity)
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
