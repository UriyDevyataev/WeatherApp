//
//  CoreDataStorage.swift
//  WeatherApp
//
//  Created by Юрий Девятаев on 28.01.2022.
//

import Foundation
import UIKit
import CoreData

protocol CoreDataStorage {
    func fetchList() -> [CWEntity]
    func addToList(city: CWEntity)
    func deleteFromList(index: Int)
    func updateList(index: Int, entity: CWEntity)
}

final class CoreDataStorageImp: CoreDataStorage  {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func fetchList() -> [CWEntity] {
        var array = [CWEntity]()
        guard let request = try? context.fetch(Cities.fetchRequest()) else {
            return array
        }
        
        let sortRequest = request.sorted{$0.date! < $1.date!}
        let decoder = JSONDecoder()
        sortRequest.forEach { row in
            guard let data: Data = row.city else {return}
            guard let city = try? decoder.decode(CWEntity.self, from: data) else {return}
            array.append(city)
        }
        return array//.count != 0 ? array : nil
    }
    
    func addToList(city: CWEntity){
        let newRow = Cities(context: context)
        let encoder = JSONEncoder()
        
        guard let data: Data = try? encoder.encode(city) else {return}
        newRow.city = data
        newRow.date = Date()
        
        context.perform {
            try? self.context.save()
        }
    }
    
    func deleteFromList(index: Int) {
        guard let request = try? context.fetch(Cities.fetchRequest()) else {return}
        let sortRequest = request.sorted{$0.date! < $1.date!}
        if index < sortRequest.count {
            let city = sortRequest[index]
            context.delete(city)
            context.perform {
                try? self.context.save()
            }
        }
    }
    
    func updateList(index: Int, entity: CWEntity) {
        guard let request = try? context.fetch(Cities.fetchRequest()) else {return}
        let sortRequest = request.sorted{$0.date! < $1.date!}
        
        if index < sortRequest.count {
            let row = sortRequest[index]
            let encoder = JSONEncoder()
            guard let data: Data = try? encoder.encode(entity) else {return}
            row.city = data
            context.perform {
                try? self.context.save()
            }
        }
    }
}
