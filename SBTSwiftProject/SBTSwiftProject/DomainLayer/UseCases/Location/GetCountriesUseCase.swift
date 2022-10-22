//
//  GetCountriesUseCase.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 02.11.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

final class GetCountriesUseCase: UseCaseSync<Void, [CountryModel]> {
	private let repository: LocationRepositoryProtocol

	init(repository: LocationRepositoryProtocol) {
		self.repository = repository
	}

	override func execute(parameter: Void) -> [CountryModel] {
		return repository.getCountries()
	}
}
