//
//  GetCountriesUseCase.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 02.11.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import DomainAbstractions
import LocationDomainModels

/// Кейс получения списка всех стран
final class GetAllCountriesUseCase: UseCase {
	private let repository: CountriesRepositoryProtocol

	/// Инициализатор
	/// - Parameter repository: репозиторий
	init(repository: CountriesRepositoryProtocol) {
		self.repository = repository
	}

	func execute(input: Void) -> [Country] {
		return repository.getCountries().map({ $0.countryValue() })
	}
}
