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
}

protocol CCRouterOutput {
}

//Presenter
protocol CCPresenterInput {
    func viewIsReady()
    
    func changedSearch(text: String, lang: String)
    func changedSearch(city: CityModel)
    
    func choisedCity(index: Int)
    func deleteCity(at IndexPathRow: Int)
}

protocol CCPresenterOutput: AnyObject {
    func setState(entity: CCEntity)
}

//Interactor
protocol CCInteractorInput {
    
    func getWeatherList() -> [CWEntity]
    func updateWeatherList()
    func getCityList(for searchText: String,lang: String)
    
    func updateTemporary(entity: CWEntity)
    func updateCurrentIndex(index: Int)
    func deleteCity(index: Int)
    
    func checkConnected() -> Bool
}

protocol CCInteractorOutput: AnyObject {
    func didUpdateEntity(entity: CCEntity)
}

//Module
protocol CCModuleInput: AnyObject {
    func needUpdateOut()
}

protocol CCModuleOutput: AnyObject {
    func updateChoisedCity(index: Int)
}


//need renaiming!!!
