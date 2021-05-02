//
//  SelectCountryAssembly.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 02.11.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import DomainAbstraction
import LocationDomainAbstraction
import UIKit

/// Протокол сборщика экрана выбора страны
protocol SelectCountryAssemblyProtocol {
	func createController() -> UIViewController & SelectCountryModuleInput
}

/// Сборщик экрана выбора страны
final class SelectCountryAssembly: SelectCountryAssemblyProtocol {
	private let getCountriesUseCase: UseCaseSync<Void, [Country]>

	/// Инициализатор
	/// - Parameter useCase: useCase
	init(getCountriesUseCase: UseCaseSync<Void, [Country]>) {
		self.getCountriesUseCase = getCountriesUseCase
	}
	func createController() -> UIViewController & SelectCountryModuleInput {
		let interactor = SelectCountryInteractor(useCase: getCountriesUseCase)
		let controller = SelectCountryViewController(interactor: interactor)
		return controller
	}
}
