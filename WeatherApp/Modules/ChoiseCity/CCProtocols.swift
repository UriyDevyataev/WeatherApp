//
//  CCProtocols.swift
//  WeatherApp
//
//  Created by Юрий Девятаев on 05.01.2022.
//

import Foundation

//Router
protocol CCRouterInput {
    func showCWViewController(output: CCModuleInput?) // ok
}

protocol CCRouterOutput {
}

//Presenter
protocol CCPresenterInput {
    func viewIsReady()                  // ok
    func changedCity(text: String)      // ok
    func choisedCity(city: CityModel)   // ok
    func choisedCity(index: Int)        // ok
}

protocol CCPresenterOutput: AnyObject {
    func setState(entity: CCEntity)     // ok
}

//Interactor
protocol CCInteractorInput {
    func getWeatherList() -> [CWEntity]         // ok
    func getCityList(for searchText: String)    // ok
    func updateTemporary(entity: CWEntity)      // ok
    func updateCurrentIndex(index: Int)         // ok
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
