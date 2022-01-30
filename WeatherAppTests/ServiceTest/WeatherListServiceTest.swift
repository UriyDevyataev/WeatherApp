//
//  WeatherListServiceTest.swift
//  WeatherAppTests
//
//  Created by Юрий Девятаев on 22.01.2022.
//

import XCTest
@testable import WeatherApp

class WeatherListServiceTest: XCTestCase {
    //out of range index
    let service = WeatherListServiceImp.shared
    let cities = entityArray
    
    func test1InitialList() {
        
        //arrange
        let countBefore = service.getCountList()
        let entity = cities[0]
        
        //act
        service.updateLocaly(entity: entity)
        let countAfter = service.getCountList()
        
        //assert
        XCTAssertEqual(countBefore, 0)
        XCTAssertNotEqual(countAfter, 0)
        XCTAssertEqual(countAfter, 1)
    }
    
    func test2AddEntityInList() {
        //arrange
        let countBefore = service.getCountList()
        let entity = cities[1]
        
        //act
        
        service.updateList(entity: entity)
        let countAfter = service.getCountList()
        
        //assert
        XCTAssertEqual(countBefore, 1)
        XCTAssertEqual(countAfter, 2)
        XCTAssertGreaterThan(countAfter, countBefore)
    }

    func test3UpdateEntityInList() {
        //arrange
        let countBefore = service.getCountList()
        let list = service.getList()
        let entityBefore = list[1]
        
        //act
        var newEntity = entityBefore
        newEntity.weather = nil
        service.updateList(entity: newEntity)
        let countAfter = service.getCountList()
        
        let newList = service.getList()
        let entityAfter = newList[1]
        
        //assert
        XCTAssertEqual(countBefore, countAfter)
        XCTAssertEqual(entityBefore.city.geonameId, entityAfter.city.geonameId)
        XCTAssertNotNil(entityBefore.weather)
        XCTAssertNil(entityAfter.weather)
    }
    
    func test4DeleteEntityInList() {
        //arrange
        let countBefore = service.getCountList()
        let list = service.getList()
        let entityForDelete = list[1]
        
        //act
        service.deleteEntity(for: 1)
        let countAfter = service.getCountList()
        let newlist = service.getList()
        
        var isEqual = false
        
        newlist.forEach { entity in
            if entity.city.geonameId == entityForDelete.city.geonameId {
                isEqual = true
            }
        }
        
        //assert
        XCTAssertNotEqual(countBefore, countAfter)
        XCTAssertLessThan(countAfter, countBefore)
        XCTAssertFalse(isEqual)
    }
    
    func test4DeleteEntityInListWithOutOfRange() {
        //arrange
        let countBefore = service.getCountList()
        let deletingIndex = countBefore + 1
        
        //act
        service.deleteEntity(for: deletingIndex)
        let countAfter = service.getCountList()

        //assert
        XCTAssertEqual(countBefore, countAfter)
    }
    
    func test5UpdateAndGetCurrentIndex() {
        //arrange
        let currentIndexBefore = service.getCurrentIndex()
        let newCurrentIndex = currentIndexBefore + 1
        
        //act
        service.updateCurrentIndex(value: newCurrentIndex)
        let currentIndexAfter = service.getCurrentIndex()
        
        //assert
        XCTAssertNotEqual(currentIndexBefore, currentIndexAfter)
        XCTAssertEqual(currentIndexAfter, newCurrentIndex)
    }
    
    func test6UpdateAndGetCurrentIndexWithOutOfRange() {
        //arrange
        let currentIndexBefore = service.getCurrentIndex()
        let newCurrentIndex = service.getCountList() + 1
        
        //act
        service.updateCurrentIndex(value: newCurrentIndex)
        let currentIndexAfter = service.getCurrentIndex()
        
        //assert
        XCTAssertNotEqual(currentIndexAfter, newCurrentIndex)
        XCTAssertEqual(currentIndexBefore, currentIndexAfter)
    }
    
    func test7UpdateTempraryEntity() {
        //arrange
        let countBefore = service.getCountList()
        let newTempEntity = cities[2]
        
        //act
        service.setTemporary(entity: newTempEntity)
        let tempEntity = service.getTemporaryEntity()
        let countAfter = service.getCountList()
        
        //assert
        XCTAssertEqual(countBefore, countAfter)
        XCTAssertEqual(newTempEntity.city.geonameId, tempEntity?.city.geonameId)
    }
    
    func test8SaveTempraryEntity() {
        //arrange
        let countBefore = service.getCountList()
        let newTempEntity = cities[2]
        
        //act
        service.setTemporary(entity: newTempEntity)
        service.saveTemporaryEntity()
        
        let list = service.getList()
        let lastSavedEntity = list.last
        let countAfter = service.getCountList()
        
        //assert
        XCTAssertNotEqual(countBefore, countAfter)
        XCTAssertGreaterThan(countAfter, countBefore)
        XCTAssertEqual(newTempEntity.city.geonameId, lastSavedEntity?.city.geonameId)
    }
}
