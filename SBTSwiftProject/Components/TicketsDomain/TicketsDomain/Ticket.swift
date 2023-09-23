//
//  Ticket.swift
//  TicketsDomain
//
//  Created by Константин Богданов on 21.09.2023.
//

/// Модель билета
public struct Ticket {

	/// Код города отправления
	public let fromCityCode: String

	/// Город назначения
	public let toCityCode: String

	/// Код авиалинии
	public let airlineCode: String

	/// Дата вылета.
	public let departureDate: Date

	/// Дата вылета обратно.
	public let arrivalDate: Date

	/// Цена билетов туда и обратно.
	public let cost: Int

	/// Номер рейса
	public let flightNumber: Int

	/// Истекает
	public let expires: Date

	public init(fromCityCode: String,
				toCityCode: String,
				airlineCode: String,
				departureDate: Date,
				arrivalDate: Date,
				cost: Int,
				flightNumber: Int,
				expires: Date) {
		self.fromCityCode = fromCityCode
		self.toCityCode = toCityCode
		self.airlineCode = airlineCode
		self.departureDate = departureDate
		self.arrivalDate = arrivalDate
		self.cost = cost
		self.flightNumber = flightNumber
		self.expires = expires
	}
}
