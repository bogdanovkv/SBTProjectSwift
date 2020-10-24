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
}

final class LocationRepository: LocationRepositoryProtocol {
	private let token = "fe17c550289588390f32bb8a4caf562f"
	private enum Endoint: String {
		case location = "http://www.travelpayouts.com/whereami"
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
		guard let url = URL(string: Endoint.location.rawValue) else {
			return completion(.failure(RepositoryError.urlError))
		}
		let request = NetworkRequest(url: url,
									 methon: .GET,
									 parameters: [NetworkRequest.Parameter(key: "locale", value: "ru"),
												  NetworkRequest.Parameter(key: "callback", value: ""),
												  NetworkRequest.Parameter(key: "token", value: token)])
		let onComplete: (Result<NetworkResponse<LocationModel>, Error>) -> Void = { result in
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
		networkService.perfom(request: request, onComplete)
	}

}
