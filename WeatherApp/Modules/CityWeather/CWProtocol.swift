//
//  CWProtocol.swift
//  WeatherApp
//
//  Created by Юрий Девятаев on 12.01.2022.
//

//Presenter
protocol CWPresenterInput: AnyObject  {
    
    var view: CWPresenterOutput? {get set}
    
    func viewIsReady(index: Int?)
    func actionAdd()
}

protocol CWPresenterOutput: AnyObject {
    func setState(entity: CWEntity)
}

//Interactor
protocol CWInteractorInput {
    
    var output: CWInteractorOutput? { get set }
    
    func loadEntity(atIndex: Int?) -> CWEntity?
    func updateEntity(_ entity: CWEntity, index: Int?)
    func addTemporaryEntity()
}

protocol CWInteractorOutput: AnyObject {
    func didUpdateEntity(entity: CWEntity)
}

protocol CWRouterInput {
}
protocol CWRouterOutput {
}

//Module
protocol CWModuleInput {
}
protocol CWModuleOutput: AnyObject {
}
