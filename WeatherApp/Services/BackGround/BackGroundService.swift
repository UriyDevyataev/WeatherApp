//
//  BackGroundServiceImp.swift
//  WeatherApp
//
//  Created by Юрий Девятаев on 18.01.2022.
//

import Foundation
import UIKit

private enum TimeOfDay: String {
    case day = "#476194"
    case night = "#1E2438"
}

protocol BackGroundService {
    func configFor(condition: String) -> Background
}

class BackGroundServiceImp: BackGroundService {
    
    func configFor(condition: String) -> Background {
        
        let timeOfDay = condition.last
                
        var timesOfDayColor = ""
        switch timeOfDay {
        case "n" : timesOfDayColor = TimeOfDay.night.rawValue
        case "d": timesOfDayColor = TimeOfDay.day.rawValue
        default: timesOfDayColor = "#FFFFFF"
        }
        
        let nodesArray = updateNodes(for: condition)
        let backGround = Background(timesOfDay: timesOfDayColor, nodes: nodesArray)
        return backGround
    }
    
    private func updateNodes(for condition: String) -> [Node] {
        
        var nodesArray = [Node]()
        
        let nodeSun = createNode(with: "Sun")
        let nodeNight = createNode(with: "Night")
        let nodeClouds = createNode(with: "Clouds")
        let nodeRain = createNode(with: "RainLight")
        let nodeSnow = createNode(with: "SnowLight")
        let nodeMist = createNode(with: "Mist")
        
        let cond = "\(condition.dropLast())"
        let timeOfDay = condition.last
        
        switch cond {
        case "01" :
            if timeOfDay == "d" {
                nodesArray.append(nodeSun)
            } else {
                nodesArray.append(nodeNight)
            }
        case "02" :
            if timeOfDay == "d" {
                nodesArray.append(nodeSun)
            } else {
                nodesArray.append(nodeNight)
            }
            nodesArray.append(nodeClouds)
        case "03" :
            nodesArray.append(nodeClouds)
        case "04" :
            nodesArray.append(nodeClouds)
        case "09" :
            nodesArray.append(nodeClouds)
            nodesArray.append(nodeRain)
        case "10" :
            nodesArray.append(nodeRain)
        case "11" :
            nodesArray.append(nodeClouds)
        case "13" :
            nodesArray.append(nodeClouds)
            nodesArray.append(nodeSnow)
        case "50" :
            if timeOfDay == "n" {
                nodesArray.append(nodeNight)
            }
            nodesArray.append(nodeMist)
        default: break
        }
        return nodesArray
    }
    
    private func createNode(with name: String) -> Node {
        
        let height = UIScreen.main.bounds.size.height
        var node = Node(name: name, position: .zero)

        switch name {
        case "Sun" :        node.position = CGPoint(x: 60, y: height - 100)
        case "Night" :      node.position = CGPoint(x: 100, y: height - 100)
        case "Clouds" :     node.position = CGPoint(x: 100, y: height - 100)
        case "RainLight" :  node.position = CGPoint(x: 0, y: height)
        case "SnowLight" :  node.position = CGPoint(x: 0, y: height)
        case "Mist" :       node.position = CGPoint(x: 100, y: height - 100)
        default:            break
        }
        return node
    }
}
