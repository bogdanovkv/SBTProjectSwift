//
//  NetworkServiceWithLogs.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 23.09.2023.
//  Copyright © 2023 Константин Богданов. All rights reserved.
//

import NetworkingAbstractions
import OSLog

final class NetworkServiceWithLogs: NetworkServiceProtocol {

	private let service: NetworkServiceProtocol

	init(service: NetworkServiceProtocol) {
		self.service = service
	}

	func perfom<Model>(request: NetworkRequest, _ completion: @escaping (Result<NetworkResponse<Model>, Error>) -> Void) where Model : Decodable {

		let onComplete: (Result<NetworkResponse<Model>, Error>) -> Void = { result in

			switch result {
			case let .success(response):
				Logger.network.log("Request: \(request.url) \n Type: \(request.method.rawValue)\n Response code: \(response.httpCode) Response: \(response.data.stringOrEmpty)")
			case let .failure(error):
				Logger.network.error("Request: \(request.url) \n Type: \(request.method.rawValue)\n Error: \(error)")
			}
			completion(result)
		}

		service.perfom(request: request, onComplete)
	}

	func download(request: NetworkingAbstractions.NetworkRequest, _ completion: @escaping (Result<URL, Error>) -> Void) {

	}
}

private extension Optional {
	var stringOrEmpty: String {
		if let self = self {
			return "\(self)"
		}
		return ""
	}
}
