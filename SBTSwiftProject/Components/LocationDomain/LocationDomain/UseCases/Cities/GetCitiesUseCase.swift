//
//  GetCitiesUseCase.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 03.11.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import DomainAbstractions
import LocationDomainModels

/// Получает города по коду страны
final class GetCitiesByCountryCodeSyncUseCase: UseCase {

	private let repository: CitiesRepositoryProtocol

	/// Инициализатор
	/// - Parameter repository: репозиторий
	init(repository: CitiesRepositoryProtocol) {
		self.repository = repository
	}

	func execute(input: String) -> [City] {
		return repository.getCities(for: input).map({ $0.cityValue() })
	}
}
