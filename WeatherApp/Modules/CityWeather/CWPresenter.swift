//
//  CWPresenter.swift
//  WeatherApp
//
//  Created by Юрий Девятаев on 12.01.2022.
//

import Foundation

class CWPresenterImp: CWPresenterInput {

    weak var view: CWPresenterOutput?
    var interactor: CWInteractorInput!
    weak var output: CCModuleInput?
    
    func viewIsReady(index: Int?) {
        
        guard let entity = interactor?.loadEntity(atIndex: index) else {
            return
        }
        view?.setState(entity: entity)
        interactor?.updateEntity(entity, index: index)
    }
    
    func actionAdd() {
        interactor?.addTemporaryEntity()
        output?.needUpdateOut()
    }
    
    func actionCancel() {
    }
}

extension CWPresenterImp: CWInteractorOutput {
    func didUpdateEntity(entity: CWEntity) {
        view?.setState(entity: entity)
    }
}
