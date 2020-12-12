//
//  TicketsSearchAssembly.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 04.11.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import UIKit

/// Протокол сборщика экрана поиска билетов
protocol TicketsSearchAssemblyProtocol {

	/// Создает контроллер
	/// - Parameters:
	///   - city: город пользователя
	///   - coutry: страна пользователя
	func createViewController(with city: CityModel, coutry: CountryModel) -> UIViewController
}

/// Сборщик экрана поиска билетов
final class TicketsSearchAssembly: TicketsSearchAssemblyProtocol {
	func createViewController(with city: CityModel, coutry: CountryModel) -> UIViewController {
		let interactor = TicketsSearchInteractor()
		let router = TicketsSearchRouter(selectCountryAssembly: SelectCountryAssembly(),
										 selectCityAssembly: SelectCityAssembly(),
										 ticketAssembly: TiketViewControllerAssembly(),
										 alertsControllerAssembly: AlertControllerAssembly())
		let controller = TicketsSearchViewController(departureCity: city,
													 departureCountry: coutry,
													 interactor: interactor,
													 router: router)
		interactor.output = controller
		return controller
	}
}
