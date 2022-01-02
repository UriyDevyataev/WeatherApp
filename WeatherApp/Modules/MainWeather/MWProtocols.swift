//
//  MWProtocols.swift
//  WeatherApp
//
//  Created by Юрий Девятаев on 02.01.2022.
//

//Router
protocol MWRouterInput {
    
}

protocol MWRouterOutput {
    
}

//Presenter
protocol MWPresenterInput {
    
    var view: MWPresenterOutput? {get set}
    
    func viewIsReady()
    func actionShowChoiseCity()
    func actionGetLocalWeather()
}

protocol MWPresenterOutput: AnyObject {
    
    func setState(entity: MWEntity)
}

//Interactor
protocol MWInteractorInput {
    
    var output: MWInteractorOutput? { get set }
    func updateEntityFor(location: Coordinate?)
    func requestAccessLocation()
}

protocol MWInteractorOutput: AnyObject {
    func didUpdateEntity(entity: MWEntity)
}

//Module
protocol MWModuleInput {
    
}

protocol MWModuleOutput: AnyObject {
    
    func didUpdateEntityOut(entity: MWEntity)
    
}

