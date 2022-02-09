//
//  MWEntity.swift
//  WeatherApp
//
//  Created by Юрий Девятаев on 02.01.2022.
//

import Foundation
import UIKit

struct MWEntity: Codable{
    let count: Int
    var choisedIndex: Int
}

struct Background: Codable {
    let timesOfDay: String
    let nodes: [Node]
}

struct Node: Codable {
    let name: String
    var position: CGPoint
}
