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
	func getCities(for country: Country) -> [City]
}

final class SelectCityInteractor: SelectCityInteractorInput {
	private let useCase: UseCaseSync<Country, [City]>

	init(useCase: UseCaseSync<Country, [City]>) {
		self.useCase = useCase
	}

	convenience init() {
		self.init(useCase: Inject.domainLayer.create(closure: { $0.createGetCitiesUseCase() },
													 strategy: .new))
	}

	func getCities(for country: Country) -> [City] {
		let cities = useCase.execute(parameter: country)
		return cities.sorted(by: { first, second in
			guard let firstName = first.nameRu, let secondName = second.nameRu else {
				return first.name < second.name
			}
			return firstName < secondName
		})
	}
}
