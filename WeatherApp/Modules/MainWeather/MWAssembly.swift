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
        return configurate(controller: controller)
    }
    
    static func configurateModule(with entity: MWEntity) -> UIViewController? {
        
        let storyboard = UIStoryboard(name: "MainWeather", bundle: nil)
        guard let controller = storyboard
                .instantiateViewController(
                    withIdentifier: "MainWeatherVC") as? MWViewController else {
                    return nil
                }
        
        controller.entity = entity
        return configurate(controller: controller)
    }
    
    private static func configurate(controller: MWViewController) -> UIViewController {
        
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

    
//    static func configurateModule(with entity: MWEntity?) -> UIViewController? {
//
//        let storyboard = UIStoryboard(name: "MainWeather", bundle: nil)
//        guard let controller = storyboard
//                .instantiateViewController(
//                    withIdentifier: "MainWeatherVC") as? MWViewController else {
//                    return nil
//                }
//
//        controller.entity = entity
//
//        let presenter = MWPresenterImp()
//        let interactor = MWInteractorImp()
//        let router = MWRouterImp()
//
//        presenter.interactor = interactor
//        presenter.router = router
//        presenter.view = controller
////        presenter.output =
//
//        interactor.output = presenter
//        router.view = controller
//        controller.presenter = presenter
//
//        return controller
//    }
//}




//class MWAssembly {
//
//    static func configurateModule() -> UIViewController? {
//
//    }
//
//    func d(controller: UIViewController)-> UIViewController? {
//
//    }
//
//
//
//    static func configurateModule(with entity: MWEntity?) -> UIViewController? {
//
//        let storyboard = UIStoryboard(name: "MainWeather", bundle: nil)
//        guard let controller = storyboard
//                .instantiateViewController(
//                    withIdentifier: "MainWeatherVC") as? MWViewController else {
//                    return nil
//                }
//
//        controller.entity = entity
//
//        let presenter = MWPresenterImp()
//        let interactor = MWInteractorImp()
//        let router = MWRouterImp()
//
//        presenter.interactor = interactor
//        presenter.router = router
//        presenter.view = controller
////        presenter.output =
//
//        interactor.output = presenter
//        router.view = controller
//        controller.presenter = presenter
//
//        return controller
//    }
//}
