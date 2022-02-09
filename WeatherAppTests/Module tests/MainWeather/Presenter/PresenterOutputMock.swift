//
//  PresenterOutputMock.swift
//  WeatherAppTests
//
//  Created by Юрий Девятаев on 24.01.2022.
//

import Foundation
@testable import WeatherApp

class PresenterOutputMock: MWPresenterOutput {
    
    var setStateCount = 0
    var updateBackgroundCount = 0
    
    func setState(entity: MWEntity) {
        print("setState_mockTest")
        setStateCount += 1
    }
    
    func updateBackground(background: Background) {
        updateBackgroundCount += 1
    }
}
