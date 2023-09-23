//
//  SelectCountryInteractor.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 02.11.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import DomainAbstractions
import LocationDomain
import LocationDomainModels

/// Протокол интерактора экрана выбора страны
protocol SelectCountryInteractorInput {
	func getCountries() -> [Country]
}

/// Интерактор экрана выбора страны
final class SelectCountryInteractor: SelectCountryInteractorInput {
	private let useCase: any UseCase<Void, [Country]>

	/// Инициализатор
	/// - Parameter useCase: useCase
	init(useCase: any UseCase<Void, [Country]>) {
		self.useCase = useCase
	}

	func getCountries() -> [Country] {
		let countries = useCase.execute(input: ())
		return countries.sorted { first, second in
			guard let firstName = first.nameRu, let secondName = second.nameRu else {
				return first.name < second.name
			}
			return firstName < secondName
		}
	}
}
