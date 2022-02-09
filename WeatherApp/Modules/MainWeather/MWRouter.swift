//
//  MWRouter.swift
//  WeatherApp
//
//  Created by Юрий Девятаев on 02.01.2022.
//

import UIKit

final class MWRouterImp: MWRouterInput {
    
    weak var view: UIViewController?
    
    func showCCViewController(output: MWModuleInput?) {
        guard let view = view, let controller = CCAssembly.configurateModule(output: output) else {
            return
        }
        
        controller.modalPresentationStyle = .fullScreen
        view.present(controller, animated: true)
    }
}
