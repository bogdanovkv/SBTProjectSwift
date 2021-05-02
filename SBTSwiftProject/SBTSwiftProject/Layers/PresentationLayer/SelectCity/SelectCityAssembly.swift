//
//  SelectCityAssembly.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 02.11.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import UIKit
import LocationDomainAbstraction

/// Сборщик экрана выбра города
protocol SelectCityAssemblyProtocol {

	/// Создает контроллер
	/// - Parameter country: страна
	func createController(countryCode: String) -> UIViewController & SelectCityModuleInput
}

/// Сборщик экрана города
final class SelectCityAssembly: SelectCityAssemblyProtocol {

	func createController(countryCode: String) -> UIViewController & SelectCityModuleInput {
		let interactor = SelectCityInteractor()
		let controller = SelectCityViewController(interactor: interactor, countryCode: countryCode)
		return controller
	}
}
