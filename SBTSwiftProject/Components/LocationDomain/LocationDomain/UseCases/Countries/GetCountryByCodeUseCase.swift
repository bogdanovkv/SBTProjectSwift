//
//  File.swift
//  
//
//  Created by Константин Богданов on 30.04.2021.
//

import DomainAbstractions
import LocationDomainModels

/// Кейс получения страны по коду
final class GetCountryByCodeUseCase: UseCase {
	private let repository: CountriesRepositoryProtocol

	/// Инициализатор
	/// - Parameter repository: репозиторий
	init(repository: CountriesRepositoryProtocol) {
		self.repository = repository
	}

	func execute(input: String) -> Country? {
		return repository.getCountry(by: input)?.countryValue()
	}
}
