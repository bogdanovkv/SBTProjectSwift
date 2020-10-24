//
//  LocationRepository.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 24.10.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import Foundation

protocol LocationRepositoryProtocol {
	func loadLocation(_ completion: @escaping (Result<LocationModel, Error>) -> Void)
	func loadCities(_ completion: @escaping (Result<[CityModel], Error>) -> Void)
}

final class LocationRepository: LocationRepositoryProtocol {
	private let token = "fe17c550289588390f32bb8a4caf562f"
	private enum Endoint: String {
		case currentLocation = "http://www.travelpayouts.com/whereami"
		case allCities = "http://api.travelpayouts.com/data/cities.json"
	}
	
	private enum RepositoryError: Error {
		case urlError
		case nilData
	}
	
	let networkService: NetworkServiceProtocol

	init(networkService: NetworkServiceProtocol) {
		self.networkService = networkService
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

	private func createDefaultParams() -> [NetworkRequest.Parameter] {
		return [NetworkRequest.Parameter(key: "locale", value: "ru"),
				NetworkRequest.Parameter(key: "callback", value: ""),
				NetworkRequest.Parameter(key: "token", value: token)]
	}
}
