//
//  TicketsRepository.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 03.11.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import Inject
import NetworkAbstraction

protocol TicketsRepositoryProtocol {

	func loadTickets(fromCity: CityModel,
					 fromDate: Date?,
					 toCity: CityModel,
					 returnDate: Date?,
					 _ completion: @escaping (Result<[TicketModel], Error>) -> Void)
}

final class TicketsRepository: TicketsRepositoryProtocol {
	private let token = "fe17c550289588390f32bb8a4caf562f"

	private enum Endpoint: String {
		case popularDirection = "http://api.travelpayouts.com/v1/city-directions"
		case search = "http://api.travelpayouts.com/v1/prices/cheap"
	}

	private enum RepositoryError: Error {
		case urlError
		case nilData
	}

	private struct Resonse: Decodable {
		let success: Bool
		let data: [String: [String: TicketModel]]

		enum CodingKeys: String, CodingKey {
			case success
			case data
		}

		init(from decoder: Decoder) throws {
			let container = try decoder.container(keyedBy: CodingKeys.self)
			success = try container.decode(Bool.self, forKey: .success)
			data = try container.decode([String: [String: TicketModel]].self, forKey: .data)
		}
	}

	private let networkService: NetworkServiceProtocol

	init(networkService: NetworkServiceProtocol) {
		self.networkService = networkService
	}

	convenience init() {
		self.init(networkService: Inject.serviceLayer.create(closure: { $0.createNetworkService() },
															 strategy: .new))
	}

	func loadTickets(fromCity: CityModel,
					 fromDate: Date?,
					 toCity: CityModel,
					 returnDate: Date?,
					 _ completion: @escaping (Result<[TicketModel], Error>) -> Void) {
		guard let url = URL(string: Endpoint.search.rawValue) else {
			return completion(.failure(RepositoryError.urlError))
		}
		var parameters: [NetworkRequest.Parameter] = []
		parameters.append(.init(key: "token", value: token))
		parameters.append(.init(key: "origin", value: fromCity.codeIATA))
		parameters.append(.init(key: "destination", value: toCity.codeIATA))
		if let returnDate = returnDate {
			parameters.append(.init(key: "return_date", value: string(from: returnDate)))
		}
		if let fromDate = fromDate {
				parameters.append(.init(key: "depart_date", value: string(from: fromDate)))
		}

		let request = NetworkRequest(url: url,
									 method: .GET,
									 parameters: parameters)

		let onComplete: (Result<NetworkResponse<Resonse>, Error>) -> Void = { result in
			do {
				let result = try result.get()
				var models: [TicketModel] = []
				guard let response = result.data else {
					return completion(.success([]))
				}
				let dictionary = response.data
				dictionary.forEach { _, dict in
					dict.forEach { _, model in
						models.append(model)
					}
				}
				completion(.success(models))
			} catch {
				completion(.failure(error))
			}
		}
		networkService.perfom(request: request, onComplete)
	}

	private func string(from date: Date) -> String {
		let formatter = DateFormatter()
		formatter.dateFormat = "YYYY-MM"
		return formatter.string(from: date)
	}
}
