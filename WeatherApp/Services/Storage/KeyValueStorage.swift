//
//  KeyValueStorage.swift
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
