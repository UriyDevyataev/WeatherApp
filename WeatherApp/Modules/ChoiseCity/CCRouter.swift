//
//  CCRouter.swift
//  WeatherApp
//
//  Created by Юрий Девятаев on 05.01.2022.
//

import Foundation
import UIKit

final class CCRouterImp: CCRouterInput {

    weak var view: UIViewController?
    
    func showMWViewController(with city: CityModel) {
        
        let entity = MWEntity(city: city,
                              weather: nil)
        
        guard let view = view,
              let controller = MWAssembly
                .configurateModule(with: entity) else {return}
        
        controller.modalPresentationStyle = .pageSheet
        view.present(controller, animated: true)
    }
    
    func showMWViewController(with entity: MWEntity) {
        guard let view = view,
              let controller = MWAssembly
                .configurateModule(with: entity) else {return}
        
        controller.modalPresentationStyle = .fullScreen
        view.present(controller, animated: true)
    }
}
