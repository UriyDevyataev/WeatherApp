//
//  Cities+CoreDataProperties.swift
//  
//
//  Created by Юрий Девятаев on 29.01.2022.
//
//

import Foundation
import CoreData

extension Cities {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Cities> {
        return NSFetchRequest<Cities>(entityName: "Cities")
    }

    @NSManaged public var city: Data?
    @NSManaged public var date: Date?
}
