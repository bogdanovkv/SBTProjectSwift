//
//  CityModel.swift
//
//  Created by Константин Богданов on 18.04.2021.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import LocationDomain

/// Модель города
struct CityDataModel: Decodable {
	private enum CodingKeys: String, CodingKey {
		case codeIATA = "code"
		case name = "name"
		case countryCode = "country_code"
		case names = "name_translations"
	}

	/// Код города
	let codeIATA: String

	/// Код страны
	let countryCode: String

	/// Название города на английском
	let name: String

	/// Название на русском
	let nameRu: String?

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		codeIATA = try container.decode(String.self, forKey: .codeIATA)
		countryCode = try container.decode(String.self, forKey: .countryCode)
		name = try container.decode(String.self, forKey: .name)
		let names = try container.decode([String: String].self, forKey: .names)
		nameRu = names["ru"]
	}
}

extension CityDataModel {
	func cityValue() -> CityModel {
		return .init(codeIATA: codeIATA,
					 countryCode: countryCode,
					 name: name,
					 nameRu: nameRu)
	}
}
