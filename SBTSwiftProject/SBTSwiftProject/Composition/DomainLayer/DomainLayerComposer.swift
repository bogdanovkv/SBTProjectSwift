//
//  DomainLayerComposer.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 02.05.2021.
//  Copyright © 2021 Константин Богданов. All rights reserved.
//

import DomainAbstractions

import LocationDomainModels
import LocationDomain

import TicketsDomain
import TicketsRepository

/// Сбощик слоя логики
protocol DomainLayerComposerProtocol {

	func composeLocationUseCase() -> any UseCaseAsync<Void, Result<Location, Error>>

	func composePrepareStorageUseCase() -> any UseCaseAsync<Void, Result<Void, Error>>

	func composeGetCountriesUseCase() -> any UseCase<Void, [Country]>

	func composeGetCitiesByCountryCodeUseCase() -> any UseCase<String, [City]>

	func composeGetCityByNameUseCase() -> any UseCase<String, City?>

	func composeGetCityByCodeUseCase() -> any UseCase<String, City?>

	func composeGetCountryByNameUseCase() -> any UseCase<String, Country?>

	func composeGetCountryByCodeUseCase() -> any UseCase<String, Country?>

	func composeSearchTicketsUseCase() -> any UseCaseAsync<TicketsSearchModel, Result<[Ticket], Error>>
}

/// Сбощик слоя логики
final class DomainLayerComposer: DomainLayerComposerProtocol {
	private let dataLayerComposer: DataLayerComposerProtocol

	/// Инициализатор
	/// - Parameter dataLayerComposer: сборщки слоя данных
	init(dataLayerComposer: DataLayerComposerProtocol) {
		self.dataLayerComposer = dataLayerComposer
	}

	func composeLocationUseCase() -> any UseCaseAsync<Void, Result<Location, Error>> {
		let repository = dataLayerComposer.composeLocationRepository()
		let assembly = LocationLogicAsembly()
		return assembly.createGetLocationusCase(locationRepository: repository)
	}

	func composePrepareStorageUseCase() -> any UseCaseAsync<Void, Result<Void, Error>> {
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

	func composeGetCountriesUseCase() -> any UseCase<Void, [Country]> {
		let repository = dataLayerComposer.composeCountriesRepository()
		let assembly = LocationLogicAsembly()
		return assembly.createGetCountriesUseCase(countriesRepository: repository)
	}

	func composeGetCitiesByCountryCodeUseCase() -> any UseCase<String, [City]> {
		let repository = dataLayerComposer.composeCitiesRepository()
		let assembly = LocationLogicAsembly()
		return assembly.createGetCitiesByCountryCodeSyncUseCase(citiesRepository: repository)
	}

	func composeGetCityByNameUseCase() -> any UseCase<String, City?> {
		let repository = dataLayerComposer.composeCitiesRepository()
		let assembly = LocationLogicAsembly()
		return assembly.createGetCitySyncUseCase(citiesRepository: repository)
	}

	func composeGetCityByCodeUseCase() -> any UseCase<String, City?> {
		let repository = dataLayerComposer.composeCitiesRepository()
		let assembly = LocationLogicAsembly()
		return assembly.createGetCityByCodeSyncUseCase(citiesRepository: repository)
	}

	func composeGetCountryByNameUseCase() -> any UseCase<String, Country?> {
		let repository = dataLayerComposer.composeCountriesRepository()
		let assembly = LocationLogicAsembly()
		return assembly.createGetCountryByNameSyncUseCase(countriesRepository: repository)
	}

	func composeGetCountryByCodeUseCase() -> any UseCase<String, Country?> {
		let repository = dataLayerComposer.composeCountriesRepository()
		let assembly = LocationLogicAsembly()
		return assembly.createGetCountryByCodeSyncUseCase(countriesRepository: repository)
	}

	func composeSearchTicketsUseCase() -> any UseCaseAsync<TicketsSearchModel, Result<[Ticket], Error>> {
		let repository = dataLayerComposer.composeTicketsRepository()
		let assembly = TicketsDomainLogicAssembly()
		return assembly.createSearchTicketsUseCase(repository: repository)
	}
}
