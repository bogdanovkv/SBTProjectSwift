//
//  AirportModel.swift
//
//  Created by Константин Богданов on 18.04.2021.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import LocationDomain

/// Модель аэропорта
struct AirportDataModel: Decodable {

	private enum CodingKeys: String, CodingKey {
		case code
		case name
		case countryCode = "country_code"
		case cityCode = "city_code"
	}

	/// Код аэропорта
	let code: String

	/// Название на английском
	let name: String

	/// Код страны
	let countryCode: String

	/// Код города
	let cityCode: String

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		code = try container.decode(String.self, forKey: .code)
		name = try container.decode(String.self, forKey: .name)
		countryCode = try container.decode(String.self, forKey: .countryCode)
		cityCode = try container.decode(String.self, forKey: .cityCode)
	}
}

extension AirportDataModel {
	func airportValue() -> AirportModel {
		return .init(code: code,
					 name: name,
					 countryCode: countryCode,
					 cityCode: cityCode)
	}
}
