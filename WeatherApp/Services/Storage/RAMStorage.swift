//
//  Fizle.swift
//  WeatherApp
//
//  Created by Юрий Девятаев on 05.01.2022.
//

import Foundation

final class RAMStorage: KeyValueStorage{
    
    var storage = [String: Any]()
    
    func getValue(key: String) -> String? {
        return storage[key] as? String
    }
    
    func getValue(key: String) -> Data? {
        return storage[key] as? Data
    }
    
    func setValue(key: String, value: String) {
        storage[key] = value
    }
    
    func setValue(key: String, value: Data) {
        storage[key] = value
    }
    
    func clear() {
        storage.removeAll()
    }
}
