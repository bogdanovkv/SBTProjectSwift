//
//  CoreDataServiceAssembly.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 23.09.2023.
//  Copyright © 2023 Константин Богданов. All rights reserved.
//

import CoreDataService
import DatabaseAbstraction

class CoreDataServiceAssembly {

	private static let service = CoreDataService()

	private init() {}

	static func createCoreDataService() -> DatabaseServiceProtocol {
		return service
	}
}
