//
//  CWProtocol.swift
//  WeatherApp
//
//  Created by Юрий Девятаев on 12.01.2022.
//

//Presenter
protocol CWPresenterInput: AnyObject  {
    
    var view: CWPresenterOutput? {get set}
    
    func viewIsReady(index: Int?)   // ok
    func actionAdd()                //ok
    func actionCancel()             // ok (not use)
}

protocol CWPresenterOutput: AnyObject {
    func setState(entity: CWEntity)
}

//Interactor
protocol CWInteractorInput {
    
    var output: CWInteractorOutput? { get set }
    
    func loadEntity(atIndex: Int?) -> CWEntity?     // ok
    func updateEntity(_ entity: CWEntity, index: Int?)           // ok
    func addTemporaryEntity()                       // ok
}

protocol CWInteractorOutput: AnyObject {
    func didUpdateEntity(entity: CWEntity) // ok
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
