//
//  GetCitiesUseCase.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 03.11.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

final class GetCitiesUseCase: UseCaseSync<CountryModel, [CityModel]> {

	private let repository: LocationRepositoryProtocol

	init(repository: LocationRepositoryProtocol) {
		self.repository = repository
	}

	override func execute(parameter: CountryModel) -> [CityModel] {
		return repository.getCities(for: parameter)
	}
}
