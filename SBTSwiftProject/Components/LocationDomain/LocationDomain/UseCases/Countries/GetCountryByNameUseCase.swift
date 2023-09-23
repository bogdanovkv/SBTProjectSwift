//
//  File.swift
//  
//
//  Created by Константин Богданов on 24.04.2021.
//

import DomainAbstractions
import LocationDomainModels

/// Кейс получения страны по имени
final class GetCountryByNameUseCase: UseCase {
	private let repository: CountriesRepositoryProtocol

	/// Инициализатор
	/// - Parameter repository: репозиторий
	init(repository: CountriesRepositoryProtocol) {
		self.repository = repository
	}

	func execute(input: String) -> Country? {
		return repository.getCountry(named: input)?.countryValue()
	}
}
