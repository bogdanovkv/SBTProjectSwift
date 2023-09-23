//
//  TicketsRepositoryProtocol.swift
//  TicketsDomain
//
//  Created by Константин Богданов on 21.09.2023.
//

/// Репозиторий по поиску билетов
public protocol TicketsRepositoryProtocol {
	
	/// Ищет билеты
	/// - Parameters:
	///   - fromCityCodeIATA: код города отправления
	///   - fromDate: дата вылета
	///   - toCityCodeIATA: код города назначения
	///   - returnDate: дата вылета обратно
	///   - completion: блок, выполняющийся по завершению загрузки
	func loadTickets(fromCityCodeIATA: String,
					 fromDate: Date?,
					 toCityCodeIATA: String,
					 returnDate: Date?) async throws -> [TicketModel]
}
