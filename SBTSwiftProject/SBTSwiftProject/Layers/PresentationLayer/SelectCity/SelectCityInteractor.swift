//
//  SelectCountryInteractor.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 02.11.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import DomainAbstractions
import LocationDomain
import LocationDomainModels

protocol SelectCityInteractorInput {
	func getCities(for countryCode: String) -> [City]
}

final class SelectCityInteractor: SelectCityInteractorInput {
	private let getCitiesByCountryCodeUseCase: any UseCase<String, [City]>

	init(getCitiesByCountryCodeUseCase: any UseCase<String, [City]>) {
		self.getCitiesByCountryCodeUseCase = getCitiesByCountryCodeUseCase
	}

	func getCities(for countryCode: String) -> [City] {
		let cities = getCitiesByCountryCodeUseCase.execute(input: countryCode)
		return cities.sorted(by: { first, second in
			guard let firstName = first.nameRu, let secondName = second.nameRu else {
				return first.name < second.name
			}
			return firstName < secondName
		})
	}
}
