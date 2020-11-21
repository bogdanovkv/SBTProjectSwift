//
//  Ticket.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 04.11.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import UIKit

/// Модель билета
struct Ticket {

	/// Город отправления
	let fromCity: CityModel

	/// Город назначения
	let toCity: CityModel

	/// Код авиалинии
	let airlineCode: String

	/// Дата вылета.
	let departureDate: Date

	/// Дата вылета обратно.
	let arrivalDate: Date

	/// Цена билетов туда и обратно.
	let cost: Int

	/// Номер рейса
	let flightNumber: Int

	/// Истекает
	let expires: Date
}
