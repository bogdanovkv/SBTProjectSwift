//
//  DataLayerComposer.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 02.05.2021.
//  Copyright © 2021 Константин Богданов. All rights reserved.
//

import TicketsRepository
import LocationRespository
import UserSettingsRepository
import LocationDomain
import TicketsDomain
/// Сборщик слоя данных
protocol DataLayerComposerProtocol {
	func composeLocationRepository() -> LocationRepositoryProtocol

	func composeCitiesRepository() -> CitiesRepositoryProtocol

	func composeCountriesRepository() -> CountriesRepositoryProtocol

	func composeAirportsRepository() -> AirportsRepositoryProtocol

	func composeSettingsRepository() -> UserSettingsRepository

	func composeTicketsRepository() -> TicketsRepositoryProtocol
}

final class DataLayerComposer: DataLayerComposerProtocol {
	private let serviceLayerComposer: ServiceLayerComposerProtocol
	private let assembly = LocationRepositoriesAssembly()
	private lazy var networkService = serviceLayerComposer.composeNetworkService()
	private lazy var dataBaseService = serviceLayerComposer.composeDatabaseService()

	init(serviceLayerComposer: ServiceLayerComposerProtocol) {
		self.serviceLayerComposer = serviceLayerComposer
	}


	func composeLocationRepository() -> LocationRepositoryProtocol {
		return assembly.createLocationRepository(networkService: networkService,
												 databaseService: dataBaseService)
	}

	func composeCitiesRepository() -> CitiesRepositoryProtocol {
		return assembly.createCitiesRepository(networkService: networkService,
											   databaseService: dataBaseService)
	}

	func composeCountriesRepository() -> CountriesRepositoryProtocol {
		return assembly.createCountriesRepository(networkService: networkService,
												  databaseService: dataBaseService)
	}

	func composeAirportsRepository() -> AirportsRepositoryProtocol {
		return assembly.createAirpotsRepository(networkService: networkService,
												databaseService: dataBaseService)
	}
	func composeSettingsRepository() -> UserSettingsRepository {
		return UserSettingsRepository(userSettings: serviceLayerComposer.composeUserSettings())
	}

	func composeTicketsRepository() -> TicketsRepositoryProtocol {
		return TicketsRepository(networkService: networkService)
	}
}
