//
//  TicketsSearchAssembly.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 04.11.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import UIKit
import LocationDomainAbstraction

/// Протокол сборщика экрана поиска билетов
protocol TicketsSearchAssemblyProtocol {

	/// Создает контроллер
	/// - Parameters:
	///   - city: город пользователя
	///   - coutry: страна пользователя
	func createViewController(with cityCode: String, coutryCode: String) -> UIViewController & TicketsSearchModuleInput
}

/// Сборщик экрана поиска билетов
final class TicketsSearchAssembly: TicketsSearchAssemblyProtocol {
	func createViewController(with cityCode: String, coutryCode: String) -> UIViewController & TicketsSearchModuleInput {
		let interactor = TicketsSearchInteractor()
		let router = TicketsSearchRouter(selectCountryAssembly: SelectCountryAssembly(),
										 selectCityAssembly: SelectCityAssembly(),
										 ticketAssembly: TiketViewControllerAssembly(),
										 alertsControllerAssembly: AlertControllerAssembly())
		let controller = TicketsSearchViewController(departureCityCode: cityCode,
													 departureCountryCode: coutryCode,
													 interactor: interactor,
													 router: router)
		interactor.output = controller
		return controller
	}
}