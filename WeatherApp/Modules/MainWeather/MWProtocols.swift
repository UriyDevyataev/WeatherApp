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
    
    func viewIsReady() //ok
    func actionShowChoiseCity()
    func actionGetLocalWeather()
    func swipeListTo(index: Int) //ok
}

protocol MWPresenterOutput: AnyObject {
    func setState(entity: MWEntity) //ok
    func updateBackground(background: Background) //ok
}

//Interactor
protocol MWInteractorInput {
    
    var output: MWInteractorOutput? { get set }
    
    func requestAccessLocation() // not ok
    func getEntity() -> MWEntity // ok
    func updateCurrentIndex(index: Int) // ok
    func getNewBackGround() -> Background //ok
    
}

protocol MWInteractorOutput: AnyObject {
    func didUpdateEntity(entity: MWEntity) // ok
    func didChangeAuthorizationLocation()
}

protocol MWModuleInput {
    func needUpdateOut()
    
}

protocol MWModuleOutput {
}
