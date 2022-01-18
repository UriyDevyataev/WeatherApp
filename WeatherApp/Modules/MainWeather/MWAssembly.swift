//
//  MWAssembly.swift
//  WeatherApp
//
//  Created by Юрий Девятаев on 02.01.2022.
//

import UIKit

class MWAssembly {
    
    static func configurateModule() -> UIViewController? {
        
        let storyboard = UIStoryboard(name: "MainWeather", bundle: nil)
        guard let controller = storyboard
                .instantiateViewController(
                    withIdentifier: "MainWeatherVC") as? MWViewController else {
                    return nil
                }
        
        controller.modalPresentationStyle = .fullScreen
        let presenter = MWPresenterImp()
        let interactor = MWInteractorImp()
        let router = MWRouterImp()
        
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = controller
//        presenter.output =
        
        interactor.output = presenter
        router.view = controller
        controller.presenter = presenter
        
        return controller
    }
}
