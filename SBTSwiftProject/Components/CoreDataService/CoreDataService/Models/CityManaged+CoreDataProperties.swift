//
//  CityManaged+CoreDataProperties.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 24.10.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//
//

import Foundation
import CoreData


extension CityManaged {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CityManaged> {
        return NSFetchRequest<CityManaged>(entityName: "CityManaged")
    }

    @NSManaged public var codeIATA: String?
    @NSManaged public var countryCode: String?
    @NSManaged public var name: String?
    @NSManaged public var nameRu: String?

}
