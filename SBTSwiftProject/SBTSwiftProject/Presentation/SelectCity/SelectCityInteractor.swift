//
//  SelectCountryInteractor.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 02.11.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import Inject
import DomainAbstraction
import LocationDomainAbstraction

protocol SelectCityInteractorInput {
	func getCities(for countryCode: String) -> [City]
}

final class SelectCityInteractor: SelectCityInteractorInput {
	private let getCitiesByCountryCodeUseCase: UseCaseSync<String, [City]>
	
	init(getCitiesByCountryCodeUseCase: UseCaseSync<String, [City]>) {
		self.getCitiesByCountryCodeUseCase = getCitiesByCountryCodeUseCase
	}
	
	convenience init() {
		self.init(getCitiesByCountryCodeUseCase: Inject.domainLayer.create(closure: { $0.createGetCitiesByCountryCodeUseCase() },
																		   strategy: .new))
	}
	
	func getCities(for countryCode: String) -> [City] {
		let cities = getCitiesByCountryCodeUseCase.execute(parameter: countryCode)
		return cities.sorted(by: { first, second in
			guard let firstName = first.nameRu, let secondName = second.nameRu else {
				return first.name < second.name
			}
			return firstName < secondName
		})
	}
}
