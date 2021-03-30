//
//  NetworkService.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 24.10.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import Foundation

protocol NetworkServiceProtocol {
	func perfom<Model: Decodable>(request: NetworkRequest,
								  _ completion: @escaping (Result<NetworkResponse<Model>, Error>) -> Void)

	func download(request: NetworkRequest,
				  _ completion: @escaping (Result<URL, Error>) -> Void)
}

final class NetworkService: NSObject, NetworkServiceProtocol {

	enum ServiceError: Error {
		case invalidUrl
		case noData
		case parsingError
	}
	
	private var session: URLSession!
	private let queue: OperationQueue
	private var downloadCompletions: [String: (Result<URL, Error>) -> Void]

	override init() {
		queue = .init()
		downloadCompletions = [:]
		super.init()
		self.session = .init(configuration: .default,
							 delegate: self,
							 delegateQueue: queue)
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

	func download(request: NetworkRequest,
				  _ completion: @escaping (Result<URL, Error>) -> Void) {
		guard var urlComponents = URLComponents(url: request.url,
												resolvingAgainstBaseURL: false) else {
			return completion(.failure(ServiceError.invalidUrl))
		}
		urlComponents.queryItems = request.parameters.map({ URLQueryItem(name: $0.key, value: $0.value) })

		guard let url = urlComponents.url else {
			return completion(.failure(ServiceError.invalidUrl))
		}

		var urlRequest = URLRequest(url: url)
		urlRequest.httpMethod = request.methon.rawValue

		let task = session.downloadTask(with: urlRequest)
		queue.addBarrierBlock { [weak self] in
			self?.downloadCompletions[url.absoluteString] = completion
		}
		task.resume()
	}
}

extension NetworkService: URLSessionDownloadDelegate {
	func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
		if let url = downloadTask.currentRequest?.url?.absoluteString,
			let completion = downloadCompletions[url] {
			completion(.success(location))
			queue.addBarrierBlock { [weak self] in
				self?.downloadCompletions[url] = nil
			}
		}
	}


	func urlSession(_ session: URLSession,
					downloadTask: URLSessionDownloadTask,
					didWriteData bytesWritten: Int64,
					totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {

	}

	func urlSession(_ session: URLSession,
					task: URLSessionTask,
					didCompleteWithError error: Error?) {
		if let url = task.currentRequest?.url?.absoluteString,
			let completion = downloadCompletions[url] {
			completion(.failure(AppError.serviceError))
			queue.addBarrierBlock { [weak self] in
				self?.downloadCompletions[url] = nil
			}
		}
	}
}
