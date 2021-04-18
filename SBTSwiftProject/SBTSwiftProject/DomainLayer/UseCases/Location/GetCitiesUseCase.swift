//
//  GetCitiesUseCase.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 03.11.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import Inject
import LocationRepositoryAbstraction

final class GetCitiesUseCase: UseCaseSync<CountryModel, [CityModel]> {

	private let repository: LocationRepositoryProtocol

	init(repository: LocationRepositoryProtocol) {
		self.repository = repository
	}

	convenience override init() {
		self.init(repository: Inject.dataLayer.create(closure: { $0.createLocationRepository() },
													  strategy: .scope(key: 0)))
	}

	override func execute(parameter: CountryModel) -> [CityModel] {
		return repository.getCities(for: parameter)
	}
}
