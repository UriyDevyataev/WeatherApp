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
        interactor.updateEntity(entity)
    }
    
    func actionGetLocalWeather() {
        interactor.updateEntity(nil)
    }
    
    func actionShowChoiseCity() {
        router.showCCViewController()
    }
    
    func actionSave(entity: MWEntity) {
        interactor.save(entity: entity)
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
