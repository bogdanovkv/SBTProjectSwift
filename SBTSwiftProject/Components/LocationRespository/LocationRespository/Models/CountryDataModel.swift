//
//  CountryModel.swift
//
//  Created by Константин Богданов on 18.04.2021.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import LocationDomain

/// Модель страны
struct CountryDataModel: Decodable {

	private enum CodingKeys: String, CodingKey {
		case codeIATA = "code"
		case name = "name"
		case countryCode = "country_code"
		case names = "name_translations"
	}

	/// Код страны
	let codeIATA: String

	/// Название страны на английском
	let name: String

	/// Название страны на русском
	let nameRu: String?

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		codeIATA = try container.decode(String.self, forKey: .codeIATA)
		name = try container.decode(String.self, forKey: .name)
		let names = try container.decode([String: String].self, forKey: .names)
		nameRu = names["ru"]
	}
}

extension CountryDataModel {
	func countryValue() -> CountryModel {
		return .init(codeIATA: codeIATA,
					 name: name,
					 nameRu: nameRu)
	}
}
