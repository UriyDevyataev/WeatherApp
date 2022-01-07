//
//  CCAssembly.swift
//  WeatherApp
//
//  Created by Юрий Девятаев on 05.01.2022.
//

import UIKit

class CCAssembly {
    static func configurateModule() -> UIViewController? {
        let storyboard = UIStoryboard(name: "ChoiseCity", bundle: nil)
        guard let controller = storyboard
                .instantiateViewController(
                    withIdentifier: "ChoiseCityVC") as? CCViewController else {
                    return nil
                }
        
        let presenter = CCPresenterImp()
        let interactor = CCInteractorImp()
        let router = CCRouterImp()
        
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
