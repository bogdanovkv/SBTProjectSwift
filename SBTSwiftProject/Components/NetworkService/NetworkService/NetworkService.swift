//
//  NetworkService.swift
//  NetworkService
//
//  Created by Константин Богданов on 23.09.2023.
//

import Foundation
import NetworkingAbstractions

public final class NetworkService: NSObject, NetworkServiceProtocol {

	private var session: URLSession!
	private let queue: OperationQueue
	private var downloadCompletions: [String: (Result<URL, Error>) -> Void]

	public override init() {
		queue = .init()
		queue.maxConcurrentOperationCount = 1
		downloadCompletions = [:]
		super.init()
		self.session = .init(configuration: .default,
							 delegate: self,
							 delegateQueue: queue)
	}

	public func perfom<Model: Decodable>(request: NetworkRequest,
								  _ completion: @escaping (Result<NetworkResponse<Model>, Error>) -> Void) {
		guard let url = URL(string: request.url),
			  var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
			return completion(.failure(NetworkServiceError.invalidUrl))
		}
		urlComponents.queryItems = request.parameters.map({ URLQueryItem(name: $0.key, value: $0.value) })

		guard let url = urlComponents.url else {
			return completion(.failure(NetworkServiceError.invalidUrl))
		}

		var urlRequest = URLRequest(url: url)
		urlRequest.httpMethod = request.method.rawValue

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
				completion(.failure(NetworkServiceError.parsingError))
			}
		}

		task.resume()
	}

	public func download(request: NetworkRequest,
				  _ completion: @escaping (Result<URL, Error>) -> Void) {
		guard let url = URL(string: request.url),
			  var urlComponents = URLComponents(url: url,
												resolvingAgainstBaseURL: false) else {
			return completion(.failure(NetworkServiceError.invalidUrl))
		}
		urlComponents.queryItems = request.parameters.map({ URLQueryItem(name: $0.key, value: $0.value) })

		guard let url = urlComponents.url else {
			return completion(.failure(NetworkServiceError.invalidUrl))
		}

		var urlRequest = URLRequest(url: url)
		urlRequest.httpMethod = request.method.rawValue

		let task = session.downloadTask(with: urlRequest)
		downloadCompletions[url.absoluteString] = completion
		task.resume()
	}
}

extension NetworkService: URLSessionDownloadDelegate {
	public func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
		if let url = downloadTask.currentRequest?.url?.absoluteString,
			let completion = downloadCompletions[url] {
			completion(.success(location))
			downloadCompletions[url] = nil
		}
	}

	public func urlSession(_ session: URLSession,
					downloadTask: URLSessionDownloadTask,
					didWriteData bytesWritten: Int64,
					totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {

	}

	public func urlSession(_ session: URLSession,
					task: URLSessionTask,
					didCompleteWithError error: Error?) {
		if let url = task.currentRequest?.url?.absoluteString,
			let completion = downloadCompletions[url] {
			if let error = error {
				completion(.failure(error))
			} else {
				completion(.failure(NetworkServiceError.undefined))
			}
			downloadCompletions[url] = nil
		}
	}
}

