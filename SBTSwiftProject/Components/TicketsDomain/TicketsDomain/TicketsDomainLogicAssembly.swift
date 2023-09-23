//
//  TicketsDomainLogicAssembly.swift
//  TicketsDomain
//
//  Created by Константин Богданов on 23.09.2023.
//

import DomainAbstractions

/// Сборщик UseCase'ов логики работы с билетами
public final class TicketsDomainLogicAssembly {

	public init() {}

	/// Создает кейс поиска билетов
	/// - Parameter repository: репозиторий билетов
	/// - Returns: use case
	public func createSearchTicketsUseCase(repository: TicketsRepositoryProtocol) -> any UseCaseAsync<TicketsSearchModel, Result<[Ticket], Error>> {
		return SearchTicketsUseCase(ticketsRepository: repository)
	}
}
