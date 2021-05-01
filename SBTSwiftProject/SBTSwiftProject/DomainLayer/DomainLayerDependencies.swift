//
//  DomainLayerDependencies.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 24.10.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import Inject
import DomainAbstraction
import LocationRepositoryAbstraction
import LocationDomainAbstraction
import LocationDomainLogic

import TicketsDomainAbstraction
import TicketsDomainLogic
import TicketsRepositoryAbstraction
import TicketsRepository

extension Inject where FactoryType == DomainLayerDependencies {
	static var domainLayer: Inject<DomainLayerDependencies> = .init(factory: DomainLayerDependencies.self)
}

struct DomainLayerDependencies: InjectFactoryProtocol {
	static var scope = "domainLayer"
	static func createLocationUseCase() -> UseCase<Void, Location> {
		let repository = DataLayerDependencies.createLocationRepository()
		let assembly = LocationLogicAsembly()
		return assembly.createGetLocationusCase(locationRepository: repository)
	}

	static func createPrepareStorageUseCase() -> UseCase<Void, Void> {
		let citiesRepository = DataLayerDependencies.createCitiesRepository()
		let countriesRepository = DataLayerDependencies.createCountriesRepository()
		let airportsRepository = DataLayerDependencies.createAirportsRepository()
		let settingsRepository = DataLayerDependencies.createSettingsRepository()
		let assembly = LocationLogicAsembly()
		return assembly.createPrepareStorageUseCase(citiesRepository: citiesRepository,
													countriesRepository: countriesRepository,
													airportsRepository: airportsRepository,
													settingsRepository: settingsRepository)
	}

	static func createGetCountriesUseCase() -> UseCaseSync<Void, [Country]> {
		let repository = DataLayerDependencies.createCountriesRepository()
		let assembly = LocationLogicAsembly()
		return assembly.createGetCountriesUseCase(countriesRepository: repository)
	}

	static func createGetCitiesByCountryCodeUseCase() -> UseCaseSync<String, [City]> {
		let repository = DataLayerDependencies.createCitiesRepository()
		let assembly = LocationLogicAsembly()
		return assembly.createGetCitiesByCountryCodeSyncUseCase(citiesRepository: repository)
	}

	static func createGetCityByNameUseCase() -> UseCaseSync<String, City?> {
		let repository = DataLayerDependencies.createCitiesRepository()
		let assembly = LocationLogicAsembly()
		return assembly.createGetCitySyncUseCase(citiesRepository: repository)
	}

	static func createGetCityByCodeUseCase() -> UseCaseSync<String, City?> {
		let repository = DataLayerDependencies.createCitiesRepository()
		let assembly = LocationLogicAsembly()
		return assembly.createGetCityByCodeSyncUseCase(citiesRepository: repository)
	}

	static func createGetCountryByNameUseCase() -> UseCaseSync<String, Country?> {
		let repository = DataLayerDependencies.createCountriesRepository()
		let assembly = LocationLogicAsembly()
		return assembly.createGetCountryByNameSyncUseCase(countriesRepository: repository)
	}

	static func createGetCountryByCodeUseCase() -> UseCaseSync<String, Country?> {
		let repository = DataLayerDependencies.createCountriesRepository()
		let assembly = LocationLogicAsembly()
		return assembly.createGetCountryByCodeSyncUseCase(countriesRepository: repository)
	}

	static func createSearchTicketsUseCase() -> UseCase<TicketsSearchModel, [Ticket]> {
		let repository = DataLayerDependencies.createTicketsRepository()
		let assembly = TicketsDomainLogicAssembly()
		return assembly.createSearchTicketsUseCase(repository: repository)
	}
}
