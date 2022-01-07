//
//  MWProtocols.swift
//  WeatherApp
//
//  Created by Юрий Девятаев on 02.01.2022.
//

import CoreLocation

//Router
protocol MWRouterInput {
    func showCCViewController()
}

protocol MWRouterOutput {
}

//Presenter
protocol MWPresenterInput {
    var view: MWPresenterOutput? {get set}
    
    func viewIsReady(with entity: MWEntity?)
    func actionShowChoiseCity()
    func actionGetLocalWeather()
    func actionSave(entity: MWEntity)
}

protocol MWPresenterOutput: AnyObject {
    func setState(entity: MWEntity)
}

//Interactor
protocol MWInteractorInput {
    
    var output: MWInteractorOutput? { get set }
    func requestAccessLocation()
    func updateEntity(_ entity: MWEntity?)
    func save(entity: MWEntity)
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
