//
//  SearchTicketsUseCase.swift
//  TicketsDomain
//
//  Created by Константин Богданов on 21.09.2023.
//

import DomainAbstractions

/// Кейс поиска билетов
final class SearchTicketsUseCase: UseCaseAsync {

	private let ticketsRepository: TicketsRepositoryProtocol

	/// Инициализатор
	/// - Parameter ticketsRepository: репозиторий билетов
	init(ticketsRepository: TicketsRepositoryProtocol) {
		self.ticketsRepository = ticketsRepository
	}

	func execute(input: TicketsSearchModel) async -> Result<[Ticket], Error> {
		do {
			let models = try await ticketsRepository.loadTickets(fromCityCodeIATA: input.fromCityCodeIATA,
														fromDate: input.fromDate,
														toCityCodeIATA: input.toCityCodeIATA,
														returnDate: input.returnDate)
			let dateFormatter = DateFormatter()
			dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
			let tickets: [Ticket] = models.compactMap({ model in
				guard let departureDate = dateFormatter.date(from: model.departureDate),
					  let arrivalDate = dateFormatter.date(from: model.arrivalDate),
					  let expiredDate = dateFormatter.date(from: model.expires) else {
					return nil
				}
				return .init(fromCityCode: input.fromCityCodeIATA,
							 toCityCode: input.toCityCodeIATA,
							 airlineCode: model.airlineCode,
							 departureDate: departureDate,
							 arrivalDate: arrivalDate,
							 cost: model.cost,
							 flightNumber: model.flightNumber,
							 expires: expiredDate)
			})
			return .success(tickets)
		} catch {
			// TODO: - обработать ошибки
			return .failure(TicketError.network)
		}
	}

}
