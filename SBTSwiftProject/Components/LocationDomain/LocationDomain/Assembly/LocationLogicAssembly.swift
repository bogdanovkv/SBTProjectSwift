//
//  File.swift
//  
//
//  Created by Константин Богданов on 24.04.2021.
//

import DomainAbstractions
import LocationDomainModels

/// Сборщик логики местоположений
public class LocationLogicAsembly {

	public init() {}

	/// Создает кейс подготовки хранилища
	/// - Parameters:
	///   - citiesRepository: репозиторий городов
	///   - countriesRepository: репозиторий стран
	///   - airportsRepository: репозиторий аэропортов
	///   - settingsRepository: репозиторий с настройками
	/// - Returns: кейс подготовки хранилища
	public func createPrepareStorageUseCase(citiesRepository: CitiesRepositoryProtocol,
											countriesRepository: CountriesRepositoryProtocol,
											airportsRepository: AirportsRepositoryProtocol,
											settingsRepository: UserSettingsRepositoryProtocol) -> any UseCaseAsync<Void, Result<Void, Error>> {
		let prepareCitiesUseCase = PrepareCitiesUseCase(repository: citiesRepository)
		let prepareAirportsUseCase = PrepareAirportsUseCase(repository: airportsRepository)
		let prepareCountriesUseCase = PrepareCountriesUseCase(repository: countriesRepository)
		let clearStorageUseCase = ClearStorageUseCaseSync(citiesRepository: citiesRepository,
														  countriesRepository: countriesRepository,
														  airportsRepository: airportsRepository)
		return PrepareStorageUseCase(settingsRepository: settingsRepository,
									 prepareAirportsUseCase: prepareAirportsUseCase,
									 prepareCountriesUseCase: prepareCitiesUseCase,
									 prepareCitiesUseCase: prepareCountriesUseCase,
									 clearStorageUseCase: clearStorageUseCase)
	}

	public func createGetCitySyncUseCase(citiesRepository: CitiesRepositoryProtocol) -> any UseCase<String, City?> {
		return GetCityByNameUseCase(repository: citiesRepository)
	}

	public func createGetCityByCodeSyncUseCase(citiesRepository: CitiesRepositoryProtocol) -> any UseCase<String, City?> {
		return GetCityByCodeUseCase(repository: citiesRepository)
	}

	public func createGetCountryByNameSyncUseCase(countriesRepository: CountriesRepositoryProtocol) -> any UseCase<String, Country?> {
		return GetCountryByNameUseCase(repository: countriesRepository)
	}

	public func createGetCountryByCodeSyncUseCase(countriesRepository: CountriesRepositoryProtocol) -> any UseCase<String, Country?> {
		return GetCountryByCodeUseCase(repository: countriesRepository)
	}

	public func createGetCitiesByCountryCodeSyncUseCase(citiesRepository: CitiesRepositoryProtocol) -> any UseCase<String, [City]> {
		return GetCitiesByCountryCodeSyncUseCase(repository: citiesRepository)
	}

	public func createGetCountriesUseCase(countriesRepository: CountriesRepositoryProtocol) -> any UseCase<Void, [Country]> {
		return GetAllCountriesUseCase(repository: countriesRepository)
	}

	public func createGetLocationusCase(locationRepository: LocationRepositoryProtocol) -> any UseCaseAsync<Void, Result<Location, Error>> {
		return LocationUseCase(repository: locationRepository)
	}
}
