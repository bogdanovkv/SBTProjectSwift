//
//  AirportModel.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 31.10.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import UIKit

struct AirportModel: Decodable {
	private enum CodingKeys: String, CodingKey {
		case code
		case name
		case countryCode = "country_code"
		case cityCode = "city_code"
	}

	let code: String
	let name: String
	let countryCode: String
	let cityCode: String

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		code = try container.decode(String.self, forKey: .code)
		name = try container.decode(String.self, forKey: .name)
		countryCode = try container.decode(String.self, forKey: .countryCode)
		cityCode = try container.decode(String.self, forKey: .cityCode)
	}


	init(code: String,
		 name: String,
		 countryCode: String,
		 cityCode: String) {
		self.code = code
		self.name = name
		self.countryCode = countryCode
		self.cityCode = cityCode
	}
}
