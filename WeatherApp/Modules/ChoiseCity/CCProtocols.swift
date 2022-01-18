//
//  CCProtocols.swift
//  WeatherApp
//
//  Created by Юрий Девятаев on 05.01.2022.
//

import Foundation

//Router
protocol CCRouterInput {
    
    func showCWViewController(output: CCModuleInput?)
    func showMWViewController()
}

protocol CCRouterOutput {
}

//Presenter
protocol CCPresenterInput {
    
    func viewIsReady()
    func changedCity(text: String)
    func choisedCity(city: CityModel)
    func choisedCity(index: Int)
    func showMWController()
//    func back()
}

protocol CCPresenterOutput: AnyObject {
    
    func setState(entity: CCEntity)
}

//Interactor
protocol CCInteractorInput {
    
    func getWeatherList() -> [CWEntity]?
    func addTemporary(entity: CWEntity)
    func reloadCityList(for searchText: String)
    func setChoisedCity(index: Int)
}

protocol CCInteractorOutput: AnyObject {
    
    func didUpdateEntity(entity: CCEntity)
}

//Module
protocol CCModuleInput: AnyObject {
    func needUpdateOut()
}

protocol CCModuleOutput: AnyObject {
}
