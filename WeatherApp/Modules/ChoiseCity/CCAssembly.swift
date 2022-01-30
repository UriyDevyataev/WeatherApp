//
//  CCAssembly.swift
//  WeatherApp
//
//  Created by Юрий Девятаев on 05.01.2022.
//

import UIKit

class CCAssembly {
    
    static func configurateModule(output: MWModuleInput?) -> UIViewController? {
        
        let controller = R.storyboard.choiseCity.choiseCityVC()
        let presenter = CCPresenterImp()
        let interactor = CCInteractorImp()
        let router = CCRouterImp()
        
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = controller
        presenter.output = output
        
        interactor.output = presenter
        router.view = controller
        controller?.presenter = presenter
        
        interactor.weatherService = WeatherServiceImp()
        interactor.weatherListService = WeatherListServiceImp.shared
        interactor.cityService = CitiesServiceImp()
        interactor.backGroundService = BackGroundServiceImp()
        interactor.connectionService = ConnectImp()
        
        return controller
    }
}
