//
//  CountryManaged+CoreDataProperties.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 24.10.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//
//

import Foundation
import CoreData


extension CountryManaged {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CountryManaged> {
        return NSFetchRequest<CountryManaged>(entityName: "CountryManaged")
    }

    @NSManaged public var name: String?
    @NSManaged public var nameRu: String?
    @NSManaged public var codeIATA: String?

}
