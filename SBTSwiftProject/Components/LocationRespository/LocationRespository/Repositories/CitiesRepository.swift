//
//  CitiesRepository.swift
//  
//
//  Created by Константин Богданов on 30.04.2021.
//

import LocationDomain
import NetworkingAbstractions
import DatabaseAbstraction
import Foundation

/// Репозиторий работы с городами
public final class CitiesRepository: CitiesRepositoryProtocol {

	private let token: String
	private let storeId: String
	private enum Endoint: String {
		case allCities = "http://api.travelpayouts.com/data/cities.json"
	}

	private let networkService: NetworkServiceProtocol
	private let databaseService: DatabaseServiceProtocol

	/// Инициализатор
	/// - Parameters:
	///   - networkService: сервис работы с сетью
	///   - databaseService: сервис работы с БД
	///   - token: токен для сервиса

	public init(networkService: NetworkServiceProtocol,
		 databaseService: DatabaseServiceProtocol,
		 token: String) {
		self.token = token
		storeId = "CityManaged"
		self.networkService = networkService
		self.databaseService = databaseService
	}

	public func loadCities(_ completion: @escaping (Result<[CityModel], Error>) -> Void) {
		let onComplete: (Result<NetworkResponse<[CityDataModel]>, Error>) -> Void = { result in
			do {
				let response = try result.get()
				guard let models = response.data else {
					return completion(.failure(LocationRepositoryError.nilData))
				}
				completion(.success(models.map { $0.cityValue() }))
			} catch {
				completion(.failure(error))
			}
		}
		let request = NetworkRequest(url: Endoint.allCities.rawValue,
									 method: .GET,
									 parameters: [])
		networkService.perfom(request: request, onComplete)
	}
	
	public func save(cities: [CityModel], completion: @escaping () -> Void) {
		let convertClosure: (CityModel, StoredObjectProtocol) -> Void = { model, databaseModel in
			databaseModel.setValue(model.name, forKey: "name")
			databaseModel.setValue(model.codeIATA, forKey: "codeIATA")
			databaseModel.setValue(model.countryCode, forKey: "countryCode")
			if let nameRu = model.nameRu {
				databaseModel.setValue(nameRu, forKey: "nameRu")
			}
		}

		databaseService.insert(storeId: storeId, models: cities, convertClosure: convertClosure, completion: completion)
	}
	
	public func getCities(for countryCode: String) -> [CityModel] {
		let convertClosure = createCityConvertClosure()
		let cities = databaseService.fetch(storeId: storeId, convertClosure: convertClosure,
										   predicate: ["countryCode": countryCode])
		return cities
	}
	
	public func getCity(named: String) -> CityModel? {
		let convertClosure = createCityConvertClosure()
		let cities = databaseService.fetch(storeId: storeId, convertClosure: convertClosure,
										   predicate: ["name": named])
		return cities.first
	}
	
	public func getCity(by codeIATA: String) -> CityModel? {
		let convertClosure = createCityConvertClosure()
		let cities = databaseService.fetch(storeId: storeId, convertClosure: convertClosure,
										   predicate: ["codeIATA": codeIATA])
		return cities.first
	}
	
	public func clearCities() {
		// TODO: change to async method
		let group = DispatchGroup()
		group.enter()
		databaseService.deleteAll(storeId: storeId) {
			group.leave()
		}
	}

	// MARK: - Private
	private func createCityConvertClosure() -> (StoredObjectProtocol) -> CityModel? {
		return { databaseModel in
			guard let codeIATA: String = databaseModel.value(forKey: "codeIATA"),
				  let countryCode: String = databaseModel.value(forKey: "countryCode"),
				  let name: String = databaseModel.value(forKey: "name") else { return nil }
			return .init(codeIATA: codeIATA, countryCode: countryCode, name: name, nameRu: databaseModel.value(forKey: "nameRu"))
		}
	}
}
