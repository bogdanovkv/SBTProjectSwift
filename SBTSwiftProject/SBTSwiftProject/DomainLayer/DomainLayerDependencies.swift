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
		let locationRepository = DataLayerDependencies.createLocationRepository()
		let settingsRepository = DataLayerDependencies.createSettingsRepository()
		let assembly = LocationLogicAsembly()
		return assembly.createPrepareStorageUseCase(locationRepository: locationRepository,
													settingsRepository: settingsRepository)
	}

	static func createGetCountriesUseCase() -> UseCaseSync<Void, [Country]> {
		let repository = DataLayerDependencies.createLocationRepository()
		let assembly = LocationLogicAsembly()
		return assembly.createGetCcountriesUseCase(locationRepository: repository)
	}

	static func createGetCitiesUseCase() -> UseCaseSync<Country, [City]> {
		let repository = DataLayerDependencies.createLocationRepository()
		let assembly = LocationLogicAsembly()
		return assembly.createGetCitiesUseCase(locationRepository: repository)
	}

	static func createGetCityUseCase() -> UseCaseSync<String, City?> {
		let repository = DataLayerDependencies.createLocationRepository()
		let assembly = LocationLogicAsembly()
		return assembly.createGetCitySyncUseCase(locationRepository: repository)
	}

	static func createGetCountryUseCase() -> UseCaseSync<String, Country?> {
		let repository = DataLayerDependencies.createLocationRepository()
		let assembly = LocationLogicAsembly()
		return assembly.createGetCountrySyncUseCase(locationRepository: repository)
	}

	static func createSearchTicketsUseCase() -> UseCase<TicketsSearchModel, [Ticket]> {
		let repository = DataLayerDependencies.createTicketsRepository()
		let assembly = TicketsDomainLogicAssembly()
		return assembly.createSearchTicketsUseCase(repository: repository)
	}
}
