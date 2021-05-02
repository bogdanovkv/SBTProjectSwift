//
//  DomainLayerComposer.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 02.05.2021.
//  Copyright © 2021 Константин Богданов. All rights reserved.
//

import DomainAbstraction

import LocationRepositoryAbstraction
import LocationDomainAbstraction
import LocationDomainLogic

import TicketsDomainAbstraction
import TicketsDomainLogic
import TicketsRepositoryAbstraction
import TicketsRepository

/// Сбощик слоя логики
protocol DomainLayerComposerProtocol {

	func composeLocationUseCase() -> UseCase<Void, Location>

	func composePrepareStorageUseCase() -> UseCase<Void, Void>

	func composeGetCountriesUseCase() -> UseCaseSync<Void, [Country]>

	func composeGetCitiesByCountryCodeUseCase() -> UseCaseSync<String, [City]>

	func composeGetCityByNameUseCase() -> UseCaseSync<String, City?>

	func composeGetCityByCodeUseCase() -> UseCaseSync<String, City?>

	func composeGetCountryByNameUseCase() -> UseCaseSync<String, Country?>

	func composeGetCountryByCodeUseCase() -> UseCaseSync<String, Country?>

	func composeSearchTicketsUseCase() -> UseCase<TicketsSearchModel, [Ticket]>
}

/// Сбощик слоя логики
final class DomainLayerComposer: DomainLayerComposerProtocol {
	private let dataLayerComposer: DataLayerComposerProtocol

	/// Инициализатор
	/// - Parameter dataLayerComposer: сборщки слоя данных
	init(dataLayerComposer: DataLayerComposerProtocol) {
		self.dataLayerComposer = dataLayerComposer
	}

	func composeLocationUseCase() -> UseCase<Void, Location> {
		let repository = dataLayerComposer.composeLocationRepository()
		let assembly = LocationLogicAsembly()
		return assembly.createGetLocationusCase(locationRepository: repository)
	}

	func composePrepareStorageUseCase() -> UseCase<Void, Void> {
		let citiesRepository = dataLayerComposer.composeCitiesRepository()
		let countriesRepository = dataLayerComposer.composeCountriesRepository()
		let airportsRepository = dataLayerComposer.composeAirportsRepository()
		let settingsRepository = dataLayerComposer.composeSettingsRepository()
		let assembly = LocationLogicAsembly()
		return assembly.createPrepareStorageUseCase(citiesRepository: citiesRepository,
													countriesRepository: countriesRepository,
													airportsRepository: airportsRepository,
													settingsRepository: settingsRepository)
	}

	func composeGetCountriesUseCase() -> UseCaseSync<Void, [Country]> {
		let repository = dataLayerComposer.composeCountriesRepository()
		let assembly = LocationLogicAsembly()
		return assembly.createGetCountriesUseCase(countriesRepository: repository)
	}

	func composeGetCitiesByCountryCodeUseCase() -> UseCaseSync<String, [City]> {
		let repository = dataLayerComposer.composeCitiesRepository()
		let assembly = LocationLogicAsembly()
		return assembly.createGetCitiesByCountryCodeSyncUseCase(citiesRepository: repository)
	}

	func composeGetCityByNameUseCase() -> UseCaseSync<String, City?> {
		let repository = dataLayerComposer.composeCitiesRepository()
		let assembly = LocationLogicAsembly()
		return assembly.createGetCitySyncUseCase(citiesRepository: repository)
	}

	func composeGetCityByCodeUseCase() -> UseCaseSync<String, City?> {
		let repository = dataLayerComposer.composeCitiesRepository()
		let assembly = LocationLogicAsembly()
		return assembly.createGetCityByCodeSyncUseCase(citiesRepository: repository)
	}

	func composeGetCountryByNameUseCase() -> UseCaseSync<String, Country?> {
		let repository = dataLayerComposer.composeCountriesRepository()
		let assembly = LocationLogicAsembly()
		return assembly.createGetCountryByNameSyncUseCase(countriesRepository: repository)
	}

	func composeGetCountryByCodeUseCase() -> UseCaseSync<String, Country?> {
		let repository = dataLayerComposer.composeCountriesRepository()
		let assembly = LocationLogicAsembly()
		return assembly.createGetCountryByCodeSyncUseCase(countriesRepository: repository)
	}

	func composeSearchTicketsUseCase() -> UseCase<TicketsSearchModel, [Ticket]> {
		let repository = dataLayerComposer.composeTicketsRepository()
		let assembly = TicketsDomainLogicAssembly()
		return assembly.createSearchTicketsUseCase(repository: repository)
	}
}
