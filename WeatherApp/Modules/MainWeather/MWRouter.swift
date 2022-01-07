//
//  MWRouter.swift
//  WeatherApp
//
//  Created by Юрий Девятаев on 02.01.2022.
//

import UIKit

final class MWRouterImp: MWRouterInput {
    
    weak var view: UIViewController?
    
    func showCCViewController() {
        guard let view = view, let controller = CCAssembly.configurateModule() else {
            return
        }
        controller.modalPresentationStyle = .fullScreen
        view.present(controller, animated: true)
    }
}
