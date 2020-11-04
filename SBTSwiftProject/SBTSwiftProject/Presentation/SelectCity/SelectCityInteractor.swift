//
//  SelectCountryInteractor.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 02.11.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import Inject

protocol SelectCityInteractorInput {
	func getCities(for country: CountryModel) -> [CityModel]
}

final class SelectCityInteractor: SelectCityInteractorInput {
	private let useCase: UseCaseSync<CountryModel, [CityModel]>

	init(useCase: UseCaseSync<CountryModel, [CityModel]>) {
		self.useCase = useCase
	}

	convenience init() {
		self.init(useCase: Inject.domainLayer.create(closure: { $0.createGetCitiesUseCase() },
													 strategy: .new))
	}

	func getCities(for country: CountryModel) -> [CityModel] {
		let cities = useCase.execute(parameter: country)
		return cities.sorted(by: { first, second in
			guard let firstName = first.nameRu, let secondName = second.nameRu else {
				return first.name < second.name
			}
			return firstName < secondName
		})
	}
}
