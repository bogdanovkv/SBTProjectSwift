//
//  GetCityByCodeUseCase.swift
//  
//
//  Created by Константин Богданов on 29.04.2021.
//

import DomainAbstractions
import LocationDomainModels

/// Кейс получения города по коду
final class GetCityByCodeUseCase: UseCase {

	private let repository: CitiesRepositoryProtocol

	/// Инициализатор
	/// - Parameter repository: репозиторий
	init(repository: CitiesRepositoryProtocol) {
		self.repository = repository
	}

	func execute(input: String) -> City? {
		return repository.getCity(by: input)?.cityValue()
	}
}
