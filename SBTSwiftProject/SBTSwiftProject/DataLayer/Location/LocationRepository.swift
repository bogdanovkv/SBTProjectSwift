//
//  LocationRepository.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 24.10.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import Inject
import DatabaseAbstraction

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
	private let coreDataService: DatabaseServiceProtocol

	init(networkService: NetworkServiceProtocol,
		 coreDataService: DatabaseServiceProtocol) {
		self.networkService = networkService
		self.coreDataService = coreDataService
	}

	convenience init() {
		let factory = Inject<ServiceLayerDependecies>.serviceLayer
		let networkService: NetworkServiceProtocol = factory.create(closure: { $0.createNetworkService() },
											strategy: .scope(key: 0))
		let databaseService: DatabaseServiceProtocol = factory.create(closure: { $0.createCoreDataService() },
											 strategy: .scope(key: 0))
		self.init(networkService: networkService,
				  coreDataService: databaseService)
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

		let convertClosure: (CountryModel, StoredObjectProtocol) -> Void = { model, databaseModel in
			databaseModel.setValue(model.name, forKey: "name")
			databaseModel.setValue(model.codeIATA, forKey: "codeIATA")
			if let nameRu = model.nameRu {
				databaseModel.setValue(nameRu, forKey: "nameRu")
			}
		}

		coreDataService.insert(storeId: "CountryManaged", models: countries,
							   convertClosure: convertClosure,
							   completion: completion)
	}

	func save(cities: [CityModel], completion: @escaping () -> Void) {

		let convertClosure: (CityModel, StoredObjectProtocol) -> Void = { model, databaseModel in
			databaseModel.setValue(model.name, forKey: "name")
			databaseModel.setValue(model.codeIATA, forKey: "codeIATA")
			databaseModel.setValue(model.countryCode, forKey: "countryCode")
			if let nameRu = model.nameRu {
				databaseModel.setValue(nameRu, forKey: "nameRu")
			}
		}

		coreDataService.insert(storeId: "CityManaged", models: cities, convertClosure: convertClosure, completion: completion)
	}

	func save(airports: [AirportModel], completion: @escaping () -> Void) {

		let convertClosure: (AirportModel, StoredObjectProtocol) -> Void = { model, databaseModel in
			databaseModel.setValue(model.name, forKey: "name")
			databaseModel.setValue(model.code, forKey: "code")
			databaseModel.setValue(model.countryCode, forKey: "countryCode")
			databaseModel.setValue(model.cityCode, forKey: "cityCode")
		}

		coreDataService.insert(storeId: "AirportManaged", models: airports, convertClosure: convertClosure, completion: completion)
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
		let convertClosure: (StoredObjectProtocol) -> CityModel? = { databaseModel in
			guard let codeIATA: String = databaseModel.value(forKey: "codeIATA"),
				let countryCode: String = databaseModel.value(forKey: "countryCode"),
				let name: String = databaseModel.value(forKey: "name") else { return nil }
			return .init(codeIATA: codeIATA, countryCode: countryCode, name: name, nameRu: databaseModel.value(forKey: "nameRu"))
		}
		let cities = coreDataService.fetch(storeId: "CityManaged", convertClosure: convertClosure,
										   predicate: ["name": name])
		return cities.first
	}

	func getCountry(with name: String) -> CountryModel? {
		let convertClosure: (StoredObjectProtocol) -> CountryModel? = { databaseModel in
			guard let codeIATA: String = databaseModel.value(forKey: "codeIATA"),
				let name: String = databaseModel.value(forKey: "name") else { return nil }
			return .init(codeIATA: codeIATA, name: name, nameRu: databaseModel.value(forKey: "nameRu"))
		}
		let cities = coreDataService.fetch(storeId: "CountryManaged", convertClosure: convertClosure,
										   predicate: ["name": name])
		return cities.first
	}

	func getCountries() -> [CountryModel] {
		let convertClosure: (StoredObjectProtocol) -> CountryModel? = { databaseModel in
			guard let codeIATA: String = databaseModel.value(forKey: "codeIATA"),
				  let name: String = databaseModel.value(forKey: "name") else { return nil }
			return .init(codeIATA: codeIATA, name: name, nameRu: databaseModel.value(forKey: "nameRu"))
		}
		let countries = coreDataService.fetch(storeId: "CountryManaged", convertClosure: convertClosure)
		return countries
	}

	func getCities(for country: CountryModel) -> [CityModel] {
		let convertClosure: (StoredObjectProtocol) -> CityModel? = { databaseModel in
			guard let codeIATA: String = databaseModel.value(forKey: "codeIATA"),
				let countryCode: String = databaseModel.value(forKey: "countryCode"),
				let name: String = databaseModel.value(forKey: "name") else { return nil }
			return .init(codeIATA: codeIATA,
						 countryCode: countryCode,
						 name: name,
						 nameRu: databaseModel.value(forKey: "nameRu"))
		}

		let cities = coreDataService.fetch(storeId: "CityManaged", convertClosure: convertClosure,
										   predicate: ["countryCode": country.codeIATA])
		return cities
	}

	func getAirports() -> [AirportModel] {
		let convertClosure: (StoredObjectProtocol) -> AirportModel? = { databaseModel in
			guard let code: String = databaseModel.value(forKey: "code"),
				let countryCode: String = databaseModel.value(forKey: "countryCode"),
				let cityCode: String = databaseModel.value(forKey: "cityCode"),
				let name: String = databaseModel.value(forKey: "name") else { return nil }
			return .init(code: code,
						 name: name,
						 countryCode: countryCode,
						 cityCode: cityCode)
		}
		let airpots = coreDataService.fetch(storeId: "AirportManaged", convertClosure: convertClosure)
		return airpots
	}

	func clearLocations() {
		let group = DispatchGroup()
		group.enter()
		group.enter()
		group.enter()
		coreDataService.deleteAll(storeId: "CityManaged") {
			group.leave()
		}
		coreDataService.deleteAll(storeId: "CountryManaged") {
			group.leave()

		}
		coreDataService.deleteAll(storeId: "AirportManaged") {
			group.leave()

		}
		group.wait()
	}

	private func createDefaultParams() -> [NetworkRequest.Parameter] {
		return [NetworkRequest.Parameter(key: "locale", value: "ru"),
				NetworkRequest.Parameter(key: "callback", value: ""),
				NetworkRequest.Parameter(key: "token", value: token)]
	}
}
