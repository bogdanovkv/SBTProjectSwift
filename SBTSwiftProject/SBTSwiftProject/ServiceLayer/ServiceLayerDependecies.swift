//
//  ServiceLayerDependecies.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 24.10.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//
import Inject
import DatabaseAbstraction
import CoreDataService
import NetworkService
import NetworkAbstraction

extension Inject where FactoryType == ServiceLayerDependecies {
	static var serviceLayer: Inject<ServiceLayerDependecies> {
			return .init(factory: ServiceLayerDependecies.self)
	}
}

struct ServiceLayerDependecies: InjectFactoryProtocol {
	static var scope = "ServiceLayer"

	private static let coreDataAssembly = CoreDataServiceAssembly()
	static func createNetworkService() -> NetworkServiceProtocol {
		return NetworkService()
	}

	static func createCoreDataService() -> DatabaseServiceProtocol {
		let service = coreDataAssembly.createCoreDataService()
		return service
	}

	static func createUserSettings() -> UserSettingsProtocol {
		return UserSettings(userDefaults: .standard)
	}
}
