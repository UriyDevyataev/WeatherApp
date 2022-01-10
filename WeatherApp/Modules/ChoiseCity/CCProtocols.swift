//
//  CCProtocols.swift
//  WeatherApp
//
//  Created by Юрий Девятаев on 05.01.2022.
//

import Foundation

//Router
protocol CCRouterInput {
    
//    func showMWViewController()
    func showMWViewController(with city: CityModel)
}

protocol CCRouterOutput {
}

//Presenter
protocol CCPresenterInput {
    
    func viewIsReady()
    func changedCity(text: String)
    func choisedCity(city: CityModel)
    func back()
}

protocol CCPresenterOutput: AnyObject {
    
    func setState(entity: CCEntity)
}

//Interactor
protocol CCInteractorInput {
    
    func getWeatherList() -> [MWEntity]?
    
    func reloadCityList(for searchText: String)
}

protocol CCInteractorOutput: AnyObject {
    
    func didUpdateEntity(entity: CCEntity)
}

//Module
protocol CCModuleInput {
}

protocol CCModuleOutput: AnyObject {
}
