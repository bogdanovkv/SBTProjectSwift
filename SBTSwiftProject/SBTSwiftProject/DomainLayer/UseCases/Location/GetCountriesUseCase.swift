//
//  GetCountriesUseCase.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 02.11.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import Inject

final class GetCountriesUseCase: UseCaseSync<Void, [CountryModel]> {
	private let repository: LocationRepositoryProtocol

	init(repository: LocationRepositoryProtocol) {
		self.repository = repository
	}

	convenience override init() {
		self.init(repository: Inject.dataLayer.create(closure: { $0.createLocationRepository() },
													  strategy: .scope(key: 0)))
	}

	override func execute(parameter: Void) -> [CountryModel] {
		return repository.getCountries()
	}
}
