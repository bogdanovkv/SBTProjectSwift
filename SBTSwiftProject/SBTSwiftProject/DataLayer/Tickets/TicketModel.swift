//
//  TicketModel.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 03.11.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import UIKit

/// Модель билета
struct TicketModel: Decodable {

	enum CodingKeys: String, CodingKey {
		case departureAt = "departure_at"
		case returnAt = "return_at"
		case airline
		case price
		case flightNumber = "flight_number"
		case expiresAt = "expires_at"
	}

	/// IATA код авиалинии.
	let airlineCode: String

	/// Дата вылета.
	let departureDate: String

	/// Дата вылета обратно.
	let arrivalDate: String

	/// Цена билетов туда и обратно.
	let cost: Int

	/// Номер рейса
	let flightNumber: Int

	let expires: String

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		airlineCode = try container.decode(String.self, forKey: .airline)
		departureDate = try container.decode(String.self, forKey: .departureAt)
		arrivalDate = try container.decode(String.self, forKey: .returnAt)
		cost = try container.decode(Int.self, forKey: .price)
		flightNumber = try container.decode(Int.self, forKey: .flightNumber)
		expires = try container.decode(String.self, forKey: .expiresAt)
	}
}
