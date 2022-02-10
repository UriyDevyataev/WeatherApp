//
//  MWProtocols.swift
//  WeatherApp
//
//  Created by Юрий Девятаев on 02.01.2022.
//

//import CoreLocation

//Router
protocol MWRouterInput {
    func showCCViewController(output: MWModuleInput?)
}

protocol MWRouterOutput {
}

//Presenter
protocol MWPresenterInput {
    
    var view: MWPresenterOutput? {get set}
    
    func viewIsReady()
    func actionShowChoiseCity()
    func actionShowLocalCity()
    func swipeListTo(index: Int)
}

protocol MWPresenterOutput: AnyObject {
    func setState(entity: MWEntity)
    func updateBackground(background: Background)
}

//Interactor
protocol MWInteractorInput {
    
    var output: MWInteractorOutput? { get set }
    
    func requestAccessLocation()
    func getEntity() -> MWEntity
    func updateCurrentIndex(index: Int)
    func getNewBackGround() -> Background
}

protocol MWInteractorOutput: AnyObject {
    func didUpdateEntity(entity: MWEntity)
    func didChangeAuthorizationLocation()
}

protocol MWModuleInput {
    func needUpdateOut()
}

protocol MWModuleOutput {
}
