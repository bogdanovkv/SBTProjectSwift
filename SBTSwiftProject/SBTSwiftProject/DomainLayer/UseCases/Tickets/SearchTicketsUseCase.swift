//
//  SearchTicketsUseCase.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 03.11.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import Foundation

/// Кейс поиска билетов
final class SearchTicketsUseCase: UseCase<TicketsSearchModel, [Ticket]> {
	private let ticketsRepository: TicketsRepositoryProtocol

	/// Инициализатор
	/// - Parameter ticketsRepository: репозиторий билетов
	init(ticketsRepository: TicketsRepositoryProtocol) {
		self.ticketsRepository = ticketsRepository
	}

	override func execute(parameter: TicketsSearchModel, _ completion: @escaping (Result<[Ticket], Error>) -> Void) {
		ticketsRepository.loadTickets(fromCity: parameter.fromCity,
									  fromDate: parameter.fromDate,
									  toCity: parameter.toCity,
									  returnDate: parameter.returnDate) { result in
			do {
				let models = try result.get()
				let dateFormatter = DateFormatter()
				dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
				let tickets: [Ticket] = models.compactMap({ model in
					guard let departureDate = dateFormatter.date(from: model.departureDate),
						  let arrivalDate = dateFormatter.date(from: model.arrivalDate),
						  let expiredDate = dateFormatter.date(from: model.expires) else {
						return nil
					}
					return .init(fromCity: parameter.fromCity,
								 toCity: parameter.toCity,
								 airlineCode: model.airlineCode,
								 departureDate: departureDate,
								 arrivalDate: arrivalDate,
								 cost: model.cost,
								 flightNumber: model.flightNumber,
								 expires: expiredDate)
				})
				completion(.success(tickets))
			} catch {
				completion(.failure(error))
			}
		}
	}

}
