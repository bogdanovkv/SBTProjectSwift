//
//  SelectCountryAssembly.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 02.11.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import UIKit

/// Протокол сборщика экрана выбора страны
protocol SelectCountryAssemblyProtocol {
	func createController() -> UIViewController & SelectCountryViewControllerInput
}

/// Сборщик экрана выбора страны
final class SelectCountryAssembly: SelectCountryAssemblyProtocol {

	private let useCase: UseCaseSync<Void, [CountryModel]>

	init(useCase: UseCaseSync<Void, [CountryModel]>) {
		self.useCase = useCase
	}

	func createController() -> UIViewController & SelectCountryViewControllerInput {
		let interactor = SelectCountryInteractor(useCase: useCase)
		let controller = SelectCountryViewController(interactor: interactor)
		return controller
	}
}
