//
//  AirportManaged+CoreDataProperties.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 31.10.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//
//

import Foundation
import CoreData


extension AirportManaged {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AirportManaged> {
        return NSFetchRequest<AirportManaged>(entityName: "AirportManaged")
    }

    @NSManaged public var name: String?
    @NSManaged public var countryCode: String?
    @NSManaged public var cityCode: String?
    @NSManaged public var code: String?

}
