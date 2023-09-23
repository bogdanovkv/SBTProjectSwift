//
//  LocationRepositoriesAssembly.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 23.09.2023.
//  Copyright © 2023 Константин Богданов. All rights reserved.
//

import NetworkingAbstractions
import LocationRespository
import CoreDataService
import DatabaseAbstraction
import LocationDomain
import NetworkService

/// СБорщик репозиториев
public final class LocationRepositoriesAssembly {
	private let token = "fe17c550289588390f32bb8a4caf562f"

	public init() {}

	/// Создает репозиторий работы с городами
	/// - Parameters:
	///   - networkService: сервис работы с сетью
	///   - databaseService: сервис работы с БД
	/// - Returns: репозиторий городов
	public func createCitiesRepository(networkService: NetworkServiceProtocol,
									   databaseService: DatabaseServiceProtocol) -> CitiesRepositoryProtocol {
		return CitiesRepository(networkService: networkService,
								databaseService: databaseService,
								token: token)
	}

	/// Создает репозиторий работы со странами
	/// - Parameters:
	///   - networkService: сервис работы с сетью
	///   - databaseService: сервис работы с БД
	/// - Returns: репозиторий стран
	public func createCountriesRepository(networkService: NetworkServiceProtocol,
										  databaseService: DatabaseServiceProtocol) -> CountriesRepositoryProtocol {
		return CountriesRepository(networkService: networkService,
								   databaseService: databaseService,
								   token: token)
	}

	/// Создает репозиторий работы с городами
	/// - Parameters:
	///   - networkService: сервис работы с сетью
	///   - databaseService: сервис работы с сетью
	/// - Returns: репозиторий аэропортов
	public func createAirpotsRepository(networkService: NetworkServiceProtocol,
										databaseService: DatabaseServiceProtocol) -> AirportsRepositoryProtocol {
		return AirportsRepository(networkService: networkService,
								  databaseService: databaseService,
								  token: token)
	}


	public func createLocationRepository(networkService: NetworkServiceProtocol,
										 databaseService: DatabaseServiceProtocol) -> LocationRepositoryProtocol {
		return LocationRepository(networkService: networkService,
								  token: token)
	}
}
