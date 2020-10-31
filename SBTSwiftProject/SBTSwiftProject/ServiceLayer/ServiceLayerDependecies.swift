//
//  ServiceLayerDependecies.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 24.10.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//
import Inject

extension Inject {
	static var serviceLayer: Inject<ServiceLayerDependecies> {
			return .init(factory: ServiceLayerDependecies.self)
	}
}

struct ServiceLayerDependecies: InjectFactoryProtocol {
	static var scope = "ServiceLayer"
	static func createNetworkService() -> NetworkServiceProtocol {
		return NetworkService()
	}

	static func createCoreDataService() -> CoreDataServiceProtocol {
		return CoreDataService()
	}

	static func createUserSettings() -> UserSettingsProtocol {
		return UserSettings(userDefaults: .standard)
	}
}
