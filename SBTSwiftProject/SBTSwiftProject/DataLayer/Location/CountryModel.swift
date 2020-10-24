//
//  CountryModel.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 24.10.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import UIKit

struct CountryModel: Decodable {
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
	let name: String
	let nameRu: String

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		codeIATA = try container.decode(String.self, forKey: .codeIATA)
		name = try container.decode(String.self, forKey: .name)
		let names = try container.decode([String: String].self, forKey: .names)
		guard let ruName = names["ru"] else {
			throw ParseErrors.cityNameRoError
		}
		nameRu = ruName
	}
}
