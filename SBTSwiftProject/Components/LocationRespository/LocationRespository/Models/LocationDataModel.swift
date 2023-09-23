//
//  LocationModel.swift
//
//  Created by Константин Богданов on 18.04.2021.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import Foundation
import LocationDomain

/// Модель местоположения
struct LocationDataModel: Decodable {
	private enum CodingKeys: String, CodingKey {
		case country = "country_name"
		case city = "name"
	}

	/// Название страны
	let country: String

	/// Название города
	let city: String

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		country = try container.decode(String.self, forKey: .country)
		city = try container.decode(String.self, forKey: .city)
	}
}

extension LocationDataModel {
	func locationValue() -> LocationModel {
		return .init(country: country,
					 city: city)
	}
}
