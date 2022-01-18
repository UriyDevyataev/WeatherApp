//
//  CWAssembly.swift
//  WeatherApp
//
//  Created by Юрий Девятаев on 12.01.2022.
//

import UIKit

class CWAssembly {
    
    static func configurateModule(output: CCModuleInput?) -> CWViewController? {
        
        let storyboard = UIStoryboard(name: "CityWeathe", bundle: nil)
        guard let controller = storyboard
                .instantiateViewController(
                    withIdentifier: "CityWeatherVC") as? CWViewController else {
                    return nil
                }
        
        let presenter = CWPresenterImp()
        let interactor = CWInteractorImp()
        
        presenter.interactor = interactor
        presenter.view = controller
        presenter.output = output
        
        interactor.output = presenter
        controller.presenter = presenter
            
        return controller
    }
}

