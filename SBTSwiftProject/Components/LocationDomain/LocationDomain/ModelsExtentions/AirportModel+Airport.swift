//
//  AirportModel+Airport.swift
//  
//
//  Created by Константин Богданов on 24.04.2021.
//

import LocationDomainModels

extension AirportModel {
	func airportValue() -> Airport {
		return .init(code: code,
					 name: name,
					 countryCode: countryCode,
					 cityCode: cityCode)
	}
}
