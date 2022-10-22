//
//  LocationRepository.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 24.10.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import Foundation

/// Репозиторий работы с локациями
protocol LocationRepositoryProtocol {

	/// Получает место где находится пользователь
	/// - Parameter completion: блок, выполняющийся при получении локации
	func loadLocation(_ completion: @escaping (Result<LocationModel, Error>) -> Void)

	/// Загружает список городов
	/// - Parameter completion: блок, выполняющийся при получении списка городов
	func loadCities(_ completion: @escaping (Result<[CityModel], Error>) -> Void)

	/// Загружает список стран
	/// - Parameter completion: блок, выполняющийся при получении списка стран
	func loadCountries(_ completion: @escaping (Result<[CountryModel], Error>) -> Void)

	/// Загружает список аэропортов
	/// - Parameter completion: блок, выполняющийся при получении списка стран
	func loadAirports(_ completion: @escaping (Result<[AirportModel], Error>) -> Void)

	/// Сохраняет страны
	/// - Parameters:
	///   - countries: страны
	///   - completion: блок, выполняющийся по завершению сохранения
	func save(countries: [CountryModel], completion: @escaping () -> Void)

	/// Сохраняет города
	/// - Parameters:
	///   - countries: города
	///   - completion: блок, выполняющийся по завершению сохранения
	func save(cities: [CityModel], completion: @escaping () -> Void)

	/// Сохраняет аэропорты
	/// - Parameters:
	///   - countries: аэропорты
	///   - completion: блок, выполняющийся по завершению сохранения
	func save(airports: [AirportModel], completion: @escaping () -> Void)

	/// Получает город по имени
	/// - Parameter name: имя
	func getCity(with name: String) -> CityModel?

	/// Получает страну по имени
	/// - Parameter name: имя
	func getCountry(with name: String) -> CountryModel?

	/// Очищает данные по городам, странам и аэропортам
	func clearLocations()

	/// Получает все страны
	func getCountries() -> [CountryModel]

	/// Получает все города
	func getCities(for country: CountryModel) -> [CityModel]

	/// Получает все аэропорты
	func getAirports() -> [AirportModel]
}

final class LocationRepository: LocationRepositoryProtocol {
	private let token = "fe17c550289588390f32bb8a4caf562f"
	private enum Endoint: String {
		case currentLocation = "http://www.travelpayouts.com/whereami"
		case allCities = "http://api.travelpayouts.com/data/cities.json"
		case allCountries = "http://api.travelpayouts.com/data/countries.json"
		case allAirports = "http://api.travelpayouts.com/data/airports.json"
	}
	
	private enum RepositoryError: Error {
		case urlError
		case nilData
	}
	
	private let networkService: NetworkServiceProtocol
	private let coreDataService: CoreDataServiceProtocol

	init(networkService: NetworkServiceProtocol,
		 coreDataService: CoreDataServiceProtocol) {
		self.networkService = networkService
		self.coreDataService = coreDataService
	}

	func loadLocation(_ completion: @escaping (Result<LocationModel, Error>) -> Void) {
		guard let url = URL(string: Endoint.currentLocation.rawValue) else {
			return completion(.failure(RepositoryError.urlError))
		}
		let request = NetworkRequest(url: url,
									 methon: .GET,
									 parameters: createDefaultParams())
		networkService.perfom(request: request, createCompletion(completion: completion))
	}

	func loadCities(_ completion: @escaping (Result<[CityModel], Error>) -> Void) {
		guard let url = URL(string: Endoint.allCities.rawValue) else {
			return completion(.failure(RepositoryError.urlError))
		}
		let request = NetworkRequest(url: url,
									 methon: .GET,
									 parameters: [])
		networkService.perfom(request: request, createCompletion(completion: completion))
	}

	func loadCountries(_ completion: @escaping (Result<[CountryModel], Error>) -> Void) {
		guard let url = URL(string: Endoint.allCountries.rawValue) else {
			return completion(.failure(RepositoryError.urlError))
		}
		let request = NetworkRequest(url: url,
									 methon: .GET,
									 parameters: [])
		networkService.download(request: request) { result in
			do {
				let url = try result.get()
				let data = try Data(contentsOf: url)
				let models = try JSONDecoder().decode([Throwable<CountryModel>].self, from: data)
				completion(.success(models.compactMap({ $0.value })))
			} catch {
				completion(.failure(error))
			}
		}
	}

	func loadAirports(_ completion: @escaping (Result<[AirportModel], Error>) -> Void) {
		guard let url = URL(string: Endoint.allAirports.rawValue) else {
			return completion(.failure(RepositoryError.urlError))
		}
		let request = NetworkRequest(url: url,
									 methon: .GET,
									 parameters: [])
		networkService.download(request: request) { result in
			do {
				let url = try result.get()
				let data = try Data(contentsOf: url)
				let models = try JSONDecoder().decode([Throwable<AirportModel>].self, from: data)
				completion(.success(models.compactMap({ $0.value })))
			} catch {
				completion(.failure(error))
			}
		}
	}

	func save(countries: [CountryModel], completion: @escaping () -> Void) {

		let convertClosure: (CountryModel, CountryManaged) -> Void = { model, managedModel in
			managedModel.name = model.name
			managedModel.codeIATA = model.codeIATA
			managedModel.nameRu = model.nameRu
		}

		coreDataService.insert(models: countries,
							   convertClosure: convertClosure,
							   completion: completion)
	}

	func save(cities: [CityModel], completion: @escaping () -> Void) {

		let convertClosure: (CityModel, CityManaged) -> Void = { model, managedModel in
			managedModel.name = model.name
			managedModel.codeIATA = model.codeIATA
			managedModel.nameRu = model.nameRu
			managedModel.countryCode = model.countryCode
		}

		coreDataService.insert(models: cities, convertClosure: convertClosure, completion: completion)
	}

	func save(airports: [AirportModel], completion: @escaping () -> Void) {

		let convertClosure: (AirportModel, AirportManaged) -> Void = { model, managedModel in
			managedModel.name = model.name
			managedModel.countryCode = model.countryCode
			managedModel.cityCode = model.cityCode
			managedModel.countryCode = model.countryCode
		}

		coreDataService.insert(models: airports, convertClosure: convertClosure, completion: completion)
	}

	private func createCompletion<Model: Decodable>(completion: @escaping (Result<Model, Error>) -> Void)
		-> (Result<NetworkResponse<Model>, Error>) -> Void {
		return { result in
			do {
				let response = try result.get()
				guard let model = response.data else {
					return completion(.failure(RepositoryError.nilData))
				}
				completion(.success(model))
			} catch {
				completion(.failure(error))
			}
		}
	}

	func getCity(with name: String) -> CityModel? {
		let predicate = NSPredicate(format: "nameRu == %@ || name == %@",
									argumentArray: [name, name])
		let convertClosure: (CityManaged) -> CityModel? = { managedModel in
			guard let codeIATA = managedModel.codeIATA,
				let countryCode = managedModel.countryCode,
				let name = managedModel.name,
				let nameRu = managedModel.nameRu else { return nil }
			return .init(codeIATA: codeIATA, countryCode: countryCode, name: name, nameRu: nameRu)
		}
		let cities = coreDataService.fetch(convertClosure: convertClosure,
										   predicate: predicate)
		return cities.first
	}

	func getCountry(with name: String) -> CountryModel? {
		let predicate = NSPredicate(format: "nameRu == %@ || name == %@",
									argumentArray: [name, name])
		let convertClosure: (CountryManaged) -> CountryModel? = { managedModel in
			guard let codeIATA = managedModel.codeIATA,
				let name = managedModel.name else { return nil }
			return .init(codeIATA: codeIATA, name: name, nameRu: managedModel.nameRu)
		}
		let cities = coreDataService.fetch(convertClosure: convertClosure,
										   predicate: predicate)
		return cities.first
	}

	func getCountries() -> [CountryModel] {
		let convertClosure: (CountryManaged) -> CountryModel? = { managedModel in
			guard let codeIATA = managedModel.codeIATA,
				let name = managedModel.name else { return nil }
			return .init(codeIATA: codeIATA, name: name, nameRu: managedModel.nameRu)
		}
		let countries = coreDataService.fetch(convertClosure: convertClosure)
		return countries
	}

	func getCities(for country: CountryModel) -> [CityModel] {
		let convertClosure: (CityManaged) -> CityModel? = { managedModel in
			guard let codeIATA = managedModel.codeIATA,
				let countryCode = managedModel.countryCode,
				let name = managedModel.name else { return nil }
			return .init(codeIATA: codeIATA,
						 countryCode: countryCode,
						 name: name,
						 nameRu: managedModel.nameRu)
		}
		let predicate = NSPredicate(format: "countryCode == %@",
									argumentArray: [country.codeIATA])

		let cities = coreDataService.fetch(convertClosure: convertClosure,
										   predicate: predicate)
		return cities
	}

	func getAirports() -> [AirportModel] {
		let convertClosure: (AirportManaged) -> AirportModel? = { managedModel in
			guard let code = managedModel.code,
				let countryCode = managedModel.countryCode,
				let cityCode = managedModel.cityCode,
				let name = managedModel.name else { return nil }
			return .init(code: code,
						 name: name,
						 countryCode: countryCode,
						 cityCode: cityCode)
		}
		let airpots = coreDataService.fetch(convertClosure: convertClosure)
		return airpots
	}

	func clearLocations() {
		coreDataService.deleteAll(type: CityManaged.self)
		coreDataService.deleteAll(type: CountryManaged.self)
		coreDataService.deleteAll(type: AirportManaged.self)
	}

	private func createDefaultParams() -> [NetworkRequest.Parameter] {
		return [NetworkRequest.Parameter(key: "locale", value: "ru"),
				NetworkRequest.Parameter(key: "callback", value: ""),
				NetworkRequest.Parameter(key: "token", value: token)]
	}
}
