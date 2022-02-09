//
//  CoreDataStorageTest.swift
//  WeatherAppTests
//
//  Created by Юрий Девятаев on 30.01.2022.
//

import XCTest
@testable import WeatherApp

class CoreDataStorageTest: XCTestCase {
    
    private let coreDataStorage = CoreDataStorageImp()
    let cities = entityArray
    
    func test1AddRow() {
        //arrange
        let list = coreDataStorage.fetchList()
        let countBefore = list.count
        let city = cities[0]
        //act
        
        coreDataStorage.addToList(city: city)
        let newList = coreDataStorage.fetchList()
        let countAfter = newList.count
        let loadedCity = newList.last
        
        //assert
        XCTAssertGreaterThan(countAfter, countBefore)
        XCTAssertEqual(city.city.geonameId, loadedCity?.city.geonameId)
    }
    
    func test2UpdateRow() {
        //arrange
        //add two cities
        var city = cities[1]
        coreDataStorage.addToList(city: city)
        city = cities[2]
        coreDataStorage.addToList(city: city)
        
        let list = coreDataStorage.fetchList()
        let countBefore = list.count
        let index = 2
        let cityBefore = list[index]
        let cityNew = cities[3]
        
        //act
        coreDataStorage.updateList(index: index, entity: cityNew)
        let newList = coreDataStorage.fetchList()
        let countAfter = newList.count
        let loadedCity = newList[index]
        
        //assert
        XCTAssertEqual(countAfter, countBefore)
        XCTAssertEqual(cityNew.city.geonameId, loadedCity.city.geonameId)
        XCTAssertNotEqual(cityBefore.city.geonameId, loadedCity.city.geonameId)
    }
    
    func test3UpdateRowWithOutOfRangeIndex() {
        //arrange
        let list = coreDataStorage.fetchList()
        let countBefore = list.count
        let index = 2
        let cityBefore = list[index]
        let cityNew = cities[4]
        
        let indexOutOfRange = countBefore + 1
        
        //act
        coreDataStorage.updateList(index: indexOutOfRange, entity: cityNew)
        let newList = coreDataStorage.fetchList()
        let countAfter = newList.count
        let loadedCity = newList[index]
        
        //assert
        XCTAssertEqual(countBefore, countAfter)
        XCTAssertEqual(cityBefore.city.geonameId, loadedCity.city.geonameId)
    }
    
    func test4DeleteRow() {
        //arrange
        let list = coreDataStorage.fetchList()
        let countBefore = list.count
        let index = 2
        let cityForDelete = list[index]
        
        //act
        coreDataStorage.deleteFromList(index: index)
        let newList = coreDataStorage.fetchList()
        let countAfter = newList.count
        
        var isContained = false
        newList.forEach{ city in
            if city.city.geonameId == cityForDelete.city.geonameId {
                isContained = true
            }
        }
        //assert
        XCTAssertNotEqual(countAfter, countBefore)
        XCTAssertLessThan(countAfter, countBefore)
        XCTAssertFalse(isContained)
    }
    
    func test4DeleteRowWithOutOfRangeIndex() {
        //arrange
        let list = coreDataStorage.fetchList()
        let countBefore = list.count
        let indexOutOfRange = countBefore + 1
        
        //act
        coreDataStorage.deleteFromList(index: indexOutOfRange)
        let newList = coreDataStorage.fetchList()
        let countAfter = newList.count
        
        //assert
        XCTAssertEqual(countAfter, countBefore)
    }
    
    func test5DeleteAll() {
        //arrange
        let list = coreDataStorage.fetchList()
        let countBefore = list.count
        
        //act
        for i in 0..<countBefore {
            print(i)
            coreDataStorage.deleteFromList(index: 0)
        }
        let newList = coreDataStorage.fetchList()
        let countAfter = newList.count
        
        //assert
        XCTAssertNotEqual(countAfter, countBefore)
        XCTAssertEqual(countAfter, 0)
        
        
    }
}
