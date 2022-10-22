//
//  DataLayerDependencies.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 24.10.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

struct DataLayerDependencies {
	static func createLocationRepository() -> LocationRepositoryProtocol {
		return LocationRepository(networkService: ServiceLayerDependencies.createNetworkService(),
								  coreDataService: ServiceLayerDependencies.createDatabaseService())
	}

	static func createSettingsRepository() -> UserSettingsRepository {
		return UserSettingsRepository(userSettings: ServiceLayerDependencies.createSettingsService())
	}

	static func createTicketsRepository() -> TicketsRepositoryProtocol {
		return TicketsRepository(networkService: ServiceLayerDependencies.createNetworkService())
	}
}
