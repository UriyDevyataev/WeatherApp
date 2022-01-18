//
//  CWProtocol.swift
//  WeatherApp
//
//  Created by Юрий Девятаев on 12.01.2022.
//

//Router
//protocol CWRouterInput {
//    func showCCViewController()
//}
//
//protocol CWRouterOutput {
//}

//Presenter
protocol CWPresenterInput {
    
    var view: CWPresenterOutput? {get set}
    
    func viewIsReady(index: Int?)
    func actionAdd()
    func actionCancel()
}

protocol CWPresenterOutput: AnyObject {
    func setState(entity: CWEntity)
}

//Interactor
protocol CWInteractorInput {
    
    var output: CWInteractorOutput? { get set }
    
    func loadEntity(atIndex: Int?) -> CWEntity?
    func updateEntity(_ entity: CWEntity)
    func addTeporaryEntity()
}

protocol CWInteractorOutput: AnyObject {
    func didUpdateEntity(entity: CWEntity)
}

//Module
protocol CWModuleInput {
}

protocol CWModuleOutput: AnyObject {
}
