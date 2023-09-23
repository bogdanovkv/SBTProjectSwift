//
//  TicketModel.swift
//  TicketsDomain
//
//  Created by Константин Богданов on 21.09.2023.
//

/// Модель билета
public struct TicketModel {

	/// IATA код авиалинии.
	public let airlineCode: String

	/// Дата вылета.
	public let departureDate: String

	/// Дата вылета обратно.
	public let arrivalDate: String

	/// Цена билетов туда и обратно.
	public let cost: Int

	/// Номер рейса
	public let flightNumber: Int

	/// Действует до
	public let expires: String

	/// Инициализатор
	/// - Parameters:
	///   - airlineCode: IATA код авиалинии
	///   - departureDate: дата вылета
	///   - arrivalDate: дата вылета обратно
	///   - cost: цена билетов туда и обратно
	///   - flightNumber: номер рейса
	///   - expires: действует до
	public init(airlineCode: String,
				departureDate: String,
				arrivalDate: String,
				cost: Int,
				flightNumber: Int,
				expires: String) {
		self.airlineCode = airlineCode
		self.departureDate = departureDate
		self.arrivalDate = arrivalDate
		self.cost = cost
		self.flightNumber = flightNumber
		self.expires = expires
	}
}
