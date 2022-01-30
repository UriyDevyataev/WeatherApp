//
//  CWAssembly.swift
//  WeatherApp
//
//  Created by Юрий Девятаев on 12.01.2022.
//

import UIKit

class CWAssembly {
    
    static func configurateModule(output: CCModuleInput?) -> CWViewController? {
        
        let controller = R.storyboard.cityWeathe.cityWeatherVC()
        let presenter = CWPresenterImp()
        let interactor = CWInteractorImp()
        
        presenter.interactor = interactor
        presenter.view = controller
        presenter.output = output
        
        interactor.output = presenter
        controller?.presenter = presenter
            
        interactor.weatherService = WeatherServiceImp()
        interactor.weatherListService = WeatherListServiceImp.shared
        interactor.locationService = LocationServiceImp()
        interactor.backGroundService = BackGroundServiceImp()
        
        return controller
    }
}

