//
//  SelectCountryInteractor.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 02.11.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

/// Протокол интерактора экрана выбора страны
protocol SelectCountryInteractorInput {
	func getCountries() -> [CountryModel]
}

/// Интерактор экрана выбора страны
final class SelectCountryInteractor: SelectCountryInteractorInput {
	private let useCase: UseCaseSync<Void, [CountryModel]>

	/// Инициализатор
	/// - Parameter useCase: useCase
	init(useCase: UseCaseSync<Void, [CountryModel]>) {
		self.useCase = useCase
	}

	func getCountries() -> [CountryModel] {
		let countries = useCase.execute(parameter: ())
		return countries.sorted { first, second in
			guard let firstName = first.nameRu, let secondName = second.nameRu else {
				return first.name < second.name
			}
			return firstName < secondName
		}
	}
}
