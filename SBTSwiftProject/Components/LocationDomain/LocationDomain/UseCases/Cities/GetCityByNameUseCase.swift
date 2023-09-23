//
//  GetCityUseCase.swift
//  
//
//  Created by Константин Богданов on 24.04.2021.
//

import DomainAbstractions
import LocationDomainModels

/// Получает город по имени
final class GetCityByNameUseCase: UseCase {
	private let repository: CitiesRepositoryProtocol

	/// Инициализатор
	/// - Parameter repository: репозиторий
	init(repository: CitiesRepositoryProtocol) {
		self.repository = repository
	}

	func execute(input: String) -> City? {
		return repository.getCity(named: input)?.cityValue()
	}
}
