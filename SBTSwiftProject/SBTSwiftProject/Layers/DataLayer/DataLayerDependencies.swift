//
//  DataLayerDependencies.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 24.10.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import Inject
import TicketsRepositoryAbstraction
import TicketsRepository
import LocationRepositoryAbstraction
import LocationRepository
import UserSettingsRepositoryAbstraction
import UserSettingsRepository

extension Inject where FactoryType == DataLayerDependencies {
	static var dataLayer: Inject<DataLayerDependencies> {
		return .init(factory: DataLayerDependencies.self)
	}
}

struct DataLayerDependencies: InjectFactoryProtocol {
	static var scope = "dataLayer"

	private static let assembly = LocationRepositoriesAssembly()

	static func createLocationRepository() -> LocationRepositoryProtocol {
		let networkService = Inject.serviceLayer.create(closure: { $0.createNetworkService() },
														strategy: .new)
		let coreDataService = Inject.serviceLayer.create(closure: { $0.createCoreDataService() },
														 strategy: .single)
		return assembly.createLocationRepository(networkService: networkService,
												 databaseService: coreDataService)
	}

	static func createCitiesRepository() -> CitiesRepositoryProtocol {
		let networkService = Inject.serviceLayer.create(closure: { $0.createNetworkService() },
														strategy: .new)
		let coreDataService = Inject.serviceLayer.create(closure: { $0.createCoreDataService() },
														 strategy: .single)
		return assembly.createCitiesRepository(networkService: networkService,
											   databaseService: coreDataService)
	}

	static func createCountriesRepository() -> CountriesRepositoryProtocol {
		let networkService = Inject.serviceLayer.create(closure: { $0.createNetworkService() },
														strategy: .new)
		let coreDataService = Inject.serviceLayer.create(closure: { $0.createCoreDataService() },
														 strategy: .single)
		return assembly.createCountriesRepository(networkService: networkService,
												  databaseService: coreDataService)
	}

	static func createAirportsRepository() -> AirportsRepositoryProtocol {
		let networkService = Inject.serviceLayer.create(closure: { $0.createNetworkService() },
														strategy: .new)
		let coreDataService = Inject.serviceLayer.create(closure: { $0.createCoreDataService() },
														 strategy: .single)
		return assembly.createAirpotsRepository(networkService: networkService,
												databaseService: coreDataService)
	}
	static func createSettingsRepository() -> UserSettingsRepository {
		let userSettingsService = Inject.serviceLayer.create(closure: { $0.createUserSettings() },
															 strategy: .new)
		return UserSettingsRepository(userSettings: userSettingsService)
	}

	static func createTicketsRepository() -> TicketsRepositoryProtocol {
		let service = Inject.serviceLayer.create(closure: { $0.createNetworkService() },
												 strategy: .new)
		return TicketsRepository(networkService: service)
	}
}