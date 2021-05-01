//
//  TicketsSearchRouter.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 04.11.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import UIKit
import LocationDomainAbstraction
import TicketsDomainAbstraction

/// Роутер экрана поиска билетов
protocol TicketsSearchRouterProtocol {

	/// Показывает алерт "Что-то пошло не так"
	func showSomethingWentWrongAlert(on viewController: UIViewController)

	/// Показывает экран смены города на контроллера
	/// - Parameters:
	///   - viewController: контроллер на котором будет показан экран
	///   - country: страна
	///   - completion: блок, который выполнится при завершении выбора города
	func showChangeCityViewController(on viewController: UIViewController,
									  country: Country,
									  completion: @escaping (String) -> Void)

	/// Показывает экран смены страны
	/// - Parameters:
	///   - viewController: контроллер на котором будет показан экран
	///   - completion: блок, который выполнится при завершении выбора страны
	func showChangeCountryViewController(on viewController: UIViewController,
										 completion: @escaping (String) -> Void)

	/// Показывает алерт с информацией что билетов не нашлось
	/// - Parameter viewController: контроллер на котором показывается алерт
	func showNoTicketsFoundAlert(on viewController: UIViewController)

	/// Показывает контроллер с и
	/// - Parameters:
	///   - viewController: контроллер на котором показывается экран
	///   - ticket: билет
	///   - fromLocation: откуда
	///   - toLocation: куда
	func showTicketInformationController(on viewController: UIViewController,
										 ticket: Ticket,
										 fromLocation: (city: City, country: Country),
										 toLocation: (city: City, country: Country))
}

/// Роутер экрана поиска билетов
final class TicketsSearchRouter: TicketsSearchRouterProtocol {

	private let selectCountryAssembly: SelectCountryAssemblyProtocol
	private let selectCityAssembly: SelectCityAssemblyProtocol
	private var changeCityAction: ((String) -> Void)?
	private var changeCountryAction: ((String) -> Void)?
	private let ticketAssembly: TiketAssemblyProtocol
	private let alertsControllerAssembly: AlertControllerAssemblyProtocol

	/// Инициализатор
	/// - Parameters:
	///   - selectCountryAssembly: сборщик экрана выбора страны
	///   - selectCityAssembly: сборщик экрана выбора города
	init(selectCountryAssembly: SelectCountryAssemblyProtocol,
		 selectCityAssembly: SelectCityAssemblyProtocol,
		 ticketAssembly: TiketAssemblyProtocol,
		 alertsControllerAssembly: AlertControllerAssemblyProtocol) {
		self.selectCityAssembly = selectCityAssembly
		self.selectCountryAssembly = selectCountryAssembly
		self.ticketAssembly = ticketAssembly
		self.alertsControllerAssembly = alertsControllerAssembly
	}

	func showChangeCityViewController(on viewController: UIViewController,
									  country: Country,
									  completion: @escaping (String) -> Void) {
		let controller = selectCityAssembly.createController(country: country)
		changeCityAction = completion
		controller.output = self
		viewController.present(controller, animated: true, completion: nil)
	}

	func showChangeCountryViewController(on viewController: UIViewController,
										 completion: @escaping (String) -> Void) {
		let controller = selectCountryAssembly.createController()
		changeCountryAction = completion
		controller.output = self
		viewController.present(controller, animated: true, completion: nil)
	}

	func showNoTicketsFoundAlert(on viewController: UIViewController) {
		let alert = alertsControllerAssembly.createController(title: "Билетов не нашлось :-(",
															  message: "К сожалению, по вашему запросу нет билетов. Попробуйте изменить параметры поиска или сидите дома.",
															  preferredStyle: .alert,
															  actions: [.init(title: "Закрыть",
																			  style: .cancel,
																			  handler: { [weak viewController] _ in
																				viewController?.presentedViewController?.dismiss(animated: true, completion: nil)
																			  })])
		viewController.present(alert, animated: true, completion: nil)
	}

	func showTicketInformationController(on viewController: UIViewController,
										 ticket: Ticket,
										 fromLocation: (city: City, country: Country),
										 toLocation: (city: City, country: Country)) {
		let ticketController = ticketAssembly.createViewCotroller(with: ticket,
																  departureLocation: (country: fromLocation.country, city: fromLocation.city),
																  destinationLocation: (country: toLocation.country, city: toLocation.city))
		ticketController.modalPresentationStyle = .fullScreen
		viewController.present(ticketController, animated: true, completion: nil)
	}

	func showSomethingWentWrongAlert(on viewController: UIViewController) {
		let alert = alertsControllerAssembly.createController(title: "Что-то пошло не так...",
															  message: "Всякое бывает",
															  preferredStyle: .alert,
															  actions: [.init(title: "Закрыть",
																			  style: .cancel,
																			  handler: { [weak viewController] _ in
																				viewController?.presentedViewController?.dismiss(animated: true, completion: nil)
																			  })])
		viewController.present(alert, animated: true, completion: nil)	}
}

extension TicketsSearchRouter: SelectCityViewControllerOutput {
	func userSelectCity(with code: String) {
		changeCityAction?(code)
		changeCityAction = nil
	}
}

extension TicketsSearchRouter: SelectCountryViewControllerOutput {
	func userSelectCountry(with code: String) {
		changeCountryAction?(code)
		changeCountryAction = nil
	}
}
