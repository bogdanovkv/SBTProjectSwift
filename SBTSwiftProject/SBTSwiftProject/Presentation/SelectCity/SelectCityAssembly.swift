//
//  SelectCityAssembly.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 02.11.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import UIKit

/// Сборщик экрана выбра города
protocol SelectCityAssemblyProtocol {

	/// Создает контроллер
	/// - Parameter country: страна
	func createController(country: CountryModel) -> UIViewController & SelectCityViewControllerInput
}

/// Сборщик экрана города
final class SelectCityAssembly: SelectCityAssemblyProtocol {

	func createController(country: CountryModel) -> UIViewController & SelectCityViewControllerInput {
		let interactor = SelectCityInteractor()
		let controller = SelectCityViewController(interactor: interactor, country: country)
		return controller
	}
}
