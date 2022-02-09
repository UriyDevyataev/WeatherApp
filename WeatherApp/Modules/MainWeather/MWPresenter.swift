//
//  MWPresenter.swift
//  WeatherApp
//
//  Created by Юрий Девятаев on 02.01.2022.
//

final class MWPresenterImp: MWPresenterInput {
    
    weak var view: MWPresenterOutput?
    var interactor: MWInteractorInput!
    var router: MWRouterInput!
    
    func viewIsReady() {
        interactor.requestAccessLocation()
    }
    
    func actionShowChoiseCity() {
        router.showCCViewController(output: self)
    }
    
    func actionShowLocalCity() {
        interactor.updateCurrentIndex(index: 0)
        let entity = interactor.getEntity()
        view?.setState(entity: entity)
        getBackGround()
    }
    
    func swipeListTo(index: Int) {
        interactor.updateCurrentIndex(index: index)
        getBackGround()
    }
    
    private func getBackGround() {
        let background = interactor.getNewBackGround()
        view?.updateBackground(background: background)
    }
}

extension MWPresenterImp: MWInteractorOutput {
    
    func didChangeAuthorizationLocation() {
        let entity = interactor.getEntity()
        view?.setState(entity: entity)
        getBackGround()
    }
    
    func didUpdateEntity(entity: MWEntity) {
        view?.setState(entity: entity)
    }
}

extension MWPresenterImp: MWModuleInput {
    func needUpdateOut() {
        let entity = interactor.getEntity()
        view?.setState(entity: entity)
        getBackGround()
    }
}
