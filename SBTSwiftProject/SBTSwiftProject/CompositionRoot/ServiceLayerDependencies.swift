//
//  ServiceLayerDependencies.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 22.10.2022.
//  Copyright © 2022 Константин Богданов. All rights reserved.
//

import UIKit

final class ServiceLayerDependencies {
	private static let coreDataService = CoreDataService()

	static func createSettingsService() -> UserSettingsProtocol {
		return UserSettings(userDefaults: .standard)
	}

	static func createDatabaseService() -> CoreDataServiceProtocol {
		return coreDataService
	}

	static func createNetworkService() -> NetworkServiceProtocol {
		return NetworkService()
	}
}
