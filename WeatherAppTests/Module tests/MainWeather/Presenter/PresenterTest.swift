//
//  PresenterTest.swift
//  WeatherAppTests
//
//  Created by Юрий Девятаев on 24.01.2022.
//

import XCTest
@testable import WeatherApp

class MWPresenterTest: XCTestCase {
    
    func test1SetState() {
        //arrange
        let presenter = MWPresenterImp()
        let interactor = MWInteractorImp()
        let view = PresenterOutputMock()
       
        let promise = XCTestExpectation(description: "fdfdff")
        presenter.interactor = interactor
        interactor.output = presenter
        presenter.view = view
        
        //act
        presenter.viewIsReady()
    
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
            let count = view.setStateCount
            
            //assert
            XCTAssertGreaterThan(count, 0)
            promise.fulfill()
        }
        wait(for: [promise], timeout: 20.0)
    }
}
