//
//  LocationRepository.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 24.10.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import Inject

protocol LocationRepositoryProtocol {
	func loadLocation(_ completion: @escaping (Result<LocationModel, Error>) -> Void)
	func loadCities(_ completion: @escaping (Result<[CityModel], Error>) -> Void)
	func loadCountries(_ completion: @escaping (Result<[CountryModel], Error>) -> Void)
	func loadAirports(_ completion: @escaping (Result<[AirportModel], Error>) -> Void)
	func save(countries: [CountryModel], completion: @escaping () -> Void)
	func save(cities: [CityModel], completion: @escaping () -> Void)
	func save(airports: [AirportModel], completion: @escaping () -> Void)
	func clearLocations()
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

	convenience init() {
		let factory = Inject<ServiceLayerDependecies>.serviceLayer
		let networkService: NetworkServiceProtocol = factory.create(closure: { $0.createNetworkService() },
											strategy: .scope(key: 0))
		let coreDataService: CoreDataServiceProtocol = factory.create(closure: { $0.createCoreDataService() },
											 strategy: .scope(key: 0))
		self.init(networkService: networkService,
				  coreDataService: coreDataService)
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
				let models = try JSONDecoder().decode([CountryModel].self, from: data)
				completion(.success(models))
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
				let models = try JSONDecoder().decode([AirportModel].self, from: data)
				completion(.success(models))
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

	func clearLocations() {
		
	}

	private func createDefaultParams() -> [NetworkRequest.Parameter] {
		return [NetworkRequest.Parameter(key: "locale", value: "ru"),
				NetworkRequest.Parameter(key: "callback", value: ""),
				NetworkRequest.Parameter(key: "token", value: token)]
	}
}
