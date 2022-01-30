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
    
    func showCWViewController(output: CCModuleInput?) {
        guard let view = view,
              let controller = CWAssembly.configurateModule(output: output) else {return}

        controller.modalPresentationStyle = .formSheet
        view.present(controller, animated: true)
    }
}
