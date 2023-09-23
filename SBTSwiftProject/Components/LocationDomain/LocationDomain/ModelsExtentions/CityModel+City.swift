//
//  CityModel+City.swift
//  
//
//  Created by Константин Богданов on 24.04.2021.
//

import LocationDomainModels

extension CityModel {
	func cityValue() -> City {
		return .init(codeIATA: codeIATA,
					 countryCode: countryCode,
					 name: name,
					 nameRu: nameRu)
	}
}
