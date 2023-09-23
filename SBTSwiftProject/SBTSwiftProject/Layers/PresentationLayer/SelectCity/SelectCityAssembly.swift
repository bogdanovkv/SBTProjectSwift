//
//  SelectCityAssembly.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 02.11.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import UIKit
import LocationDomain
import DomainAbstractions
import LocationDomainModels

/// Сборщик экрана выбра города
protocol SelectCityAssemblyProtocol {

	/// Создает контроллер
	/// - Parameter country: страна
	func createController(countryCode: String) -> UIViewController & SelectCityModuleInput
}

/// Сборщик экрана города
final class SelectCityAssembly: SelectCityAssemblyProtocol {

	private let getCitiesByCountryCodeUseCase: any UseCase<String, [City]>

	init(getCitiesByCountryCodeUseCase: any UseCase<String, [City]>) {
		self.getCitiesByCountryCodeUseCase = getCitiesByCountryCodeUseCase
	}

	func createController(countryCode: String) -> UIViewController & SelectCityModuleInput {
		let interactor = SelectCityInteractor(getCitiesByCountryCodeUseCase: getCitiesByCountryCodeUseCase)
		let controller = SelectCityViewController(interactor: interactor, countryCode: countryCode)
		return controller
	}
}