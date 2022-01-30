//
//  SharedStorage.swift
//  WeatherApp
//
//  Created by Юрий Девятаев on 05.01.2022.
//

import Foundation

protocol KeyValueStorage {
    
    func getValue(key: String) -> String?
    func getValue(key: String) -> Data?
    
    func setValue(key: String, value: String)
    func setValue(key: String, value: Data)
    
    func clear()
}

final class SharedStorage: KeyValueStorage {
    
    let storage = UserDefaults.standard
    
    func getValue(key: String) -> String? {
        return storage.value(forKey: key) as? String
    }
    
    func getValue(key: String) -> Data? {
        return storage.value(forKey: key) as? Data
    }
    
    func setValue(key: String, value: String) {
        storage.set(value, forKey: key)
    }
    
    func setValue(key: String, value: Data) {
        storage.set(value, forKey: key)
    }
    
    func clear() {
        print("clear not can")
    }
}
