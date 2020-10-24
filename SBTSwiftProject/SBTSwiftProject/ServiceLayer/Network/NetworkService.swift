//
//  NetworkService.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 24.10.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import UIKit

protocol NetworkServiceProtocol {
	func perfom<Model: Decodable>(request: NetworkRequest,
								  _ completion: @escaping (Result<NetworkResponse<Model>, Error>) -> Void)
}

final class NetworkService: NetworkServiceProtocol {

	enum ServiceError: Error {
		case invalidUrl
		case noData
		case parsingError
	}
	
	private let session: URLSession

	init(sesion: URLSession) {
		self.session = sesion
	}
	
	func perfom<Model: Decodable>(request: NetworkRequest,
								  _ completion: @escaping (Result<NetworkResponse<Model>, Error>) -> Void) {
		guard var urlComponents = URLComponents(url: request.url, resolvingAgainstBaseURL: false) else {
			return completion(.failure(ServiceError.invalidUrl))
		}
		urlComponents.queryItems = request.parameters.map({ URLQueryItem(name: $0.key, value: $0.value) })
		
		guard let url = urlComponents.url else {
			return completion(.failure(ServiceError.invalidUrl))
		}
		
		var urlRequest = URLRequest(url: url)
		urlRequest.httpMethod = request.methon.rawValue

		let task = session.dataTask(with: urlRequest) { data, response, error in
			if let error = error {
				return completion(.failure(error))
			}
			
			guard let data = data else {
				let responseModel = NetworkResponse<Model>(httpCode: (response as? HTTPURLResponse)?.statusCode ?? -1,
														   data: nil)
				return completion(.success(responseModel))
			}
			
			do {
				let model = try JSONDecoder().decode(Model.self, from: data)
				let responseModel = NetworkResponse<Model>(httpCode: (response as? HTTPURLResponse)?.statusCode ?? -1,
												   data: model)
				return completion(.success(responseModel))
			} catch {
				completion(.failure(ServiceError.parsingError))
			}
		}
		
		task.resume()
	}
}
