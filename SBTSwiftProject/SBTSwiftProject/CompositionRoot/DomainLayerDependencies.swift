//
//  DomainLayerDependencies.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 24.10.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

struct DomainLayerDependencies {

	static func createLocationUseCase() -> LocationUseCaseProtocol {
		return LocationUseCase(repository: DataLayerDependencies.createLocationRepository())
	}

	static func createPrepareStorageUseCase() -> PrepareStorageUseCaseProtocol {
		return PrepareStorageUseCase(settingsRepository: DataLayerDependencies.createSettingsRepository(),
									 locationRepository: DataLayerDependencies.createLocationRepository(),
									 prepareAirportsUseCase: PrepareAirportsUseCase(locationRepository: DataLayerDependencies.createLocationRepository()),
									 prepareCountriesUseCase: PrepareCountriesUseCase(locationRepository: DataLayerDependencies.createLocationRepository()),
									 prepareCitiesUseCase: PrepareCitiesUseCase(locationRepository: DataLayerDependencies.createLocationRepository()))
	}

	static func createGetCountriesUseCase() -> UseCaseSync<Void, [CountryModel]> {
		return GetCountriesUseCase(repository: DataLayerDependencies.createLocationRepository())
	}

	static func createGetCitiesUseCase() -> UseCaseSync<CountryModel, [CityModel]> {
		return GetCitiesUseCase(repository: DataLayerDependencies.createLocationRepository())
	}

	static func createSearchTicketsUseCase() -> UseCase<TicketsSearchModel, [Ticket]> {
		return SearchTicketsUseCase(ticketsRepository: DataLayerDependencies.createTicketsRepository())
	}
}
