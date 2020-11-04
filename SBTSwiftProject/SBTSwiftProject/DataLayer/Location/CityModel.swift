//
//  CityModel.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 24.10.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

struct CityModel: Decodable {

	private enum ParseErrors: Error {
		case cityNameRoError
	}

	private enum CodingKeys: String, CodingKey {
		case codeIATA = "code"
		case name = "name"
		case countryCode = "country_code"
		case names = "name_translations"
	}

	let codeIATA: String
	let countryCode: String
	let name: String
	let nameRu: String?

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		codeIATA = try container.decode(String.self, forKey: .codeIATA)
		countryCode = try container.decode(String.self, forKey: .countryCode)
		name = try container.decode(String.self, forKey: .name)
		let names = try container.decode([String: String].self, forKey: .names)
		nameRu = names["ru"]
	}

	init(codeIATA: String,
		 countryCode: String,
		 name: String,
		 nameRu: String?) {
		self.codeIATA = codeIATA
		self.countryCode = countryCode
		self.name = name
		self.nameRu = nameRu
	}
}
