//
//  LocationModel.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 24.10.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import Foundation

struct LocationModel: Decodable {
	private enum CodingKeys: String, CodingKey {
		case country = "country_name"
		case city = "name"
	}

	let country: String
	let city: String
	
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		country = try container.decode(String.self, forKey: .country)
		city = try container.decode(String.self, forKey: .city)
	}

	init(country: String, city: String) {
		self.city = city
		self.country = country
	}
}
