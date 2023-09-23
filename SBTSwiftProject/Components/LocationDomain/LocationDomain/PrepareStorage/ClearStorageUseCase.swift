//
//  ClearStorageUseCase.swift
//  
//
//  Created by Константин Богданов on 30.04.2021.
//

import DomainAbstractions

/// Кейс очищающий хранилище приложения от стран, городов, аэропортов
public final class ClearStorageUseCaseSync: UseCase {

	private let citiesRepository: CitiesRepositoryProtocol
	private let countriesRepository: CountriesRepositoryProtocol
	private let airportsRepository: AirportsRepositoryProtocol

	/// Инициализатор
	/// - Parameters:
	///   - citiesRepository: репозиторий городов
	///   - countriesRepository: репозиторий стран
	///   - airportsRepository: репозиторий аэропортов
	public init(citiesRepository: CitiesRepositoryProtocol,
				countriesRepository: CountriesRepositoryProtocol,
				airportsRepository: AirportsRepositoryProtocol) {
		self.citiesRepository = citiesRepository
		self.countriesRepository = countriesRepository
		self.airportsRepository = airportsRepository
	}

	public func execute(input: Void) -> Void {
		citiesRepository.clearCities()
		countriesRepository.clearCountries()
		airportsRepository.clearAipotrs()
	}
}
