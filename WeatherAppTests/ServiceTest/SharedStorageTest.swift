//
//  StorageTest.swift
//  WeatherAppTests
//
//  Created by Юрий Девятаев on 23.01.2022.
//

import XCTest
@testable import WeatherApp

class StorageTest: XCTestCase {
    
    func test1ForString() {
        
        //arrange
        let storage: KeyValueStorage = SharedStorage()
        let key = "anyKey"
        let value = "anyValue"
        
        //act
        storage.setValue(key: key, value: value)
        let storageValue: String? = storage.getValue(key: key)
        
        //assert
        XCTAssertEqual(storageValue, value)
    }
    
    func test2ForData() {
        
        //arrange
        let storage: KeyValueStorage = SharedStorage()
        let key = "anyKey"
        guard let value = Data(base64Encoded: "anyString") else {return}
        
        //act
        storage.setValue(key: key, value: value)
        let storageValue: Data? = storage.getValue(key: key)
        
        //assert
        XCTAssertEqual(storageValue, value)
    }
    
//    func test3Clear() {
//        
//        //arrange
//        let storage: KeyValueStorage = SharedStorage()
//        let key = "anyKey"
//        let value = "anyValue"
//        
//        //act
//        storage.setValue(key: key, value: value)
//        storage.clear()
//        let allValues = storage.getAllValues()
//        
//        //assert
//        XCTAssertEqual(allValues.count, 0)
//    }
}
