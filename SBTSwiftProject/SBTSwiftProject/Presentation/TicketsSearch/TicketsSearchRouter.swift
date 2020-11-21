//
//  TicketsSearchRouter.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 04.11.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import UIKit

/// Роутер экрана поиска билетов
protocol TicketsSearchRouterProtocol {

	/// Показывает экран смены города на контроллера
	/// - Parameters:
	///   - viewController: контроллер на котором будет показан экран
	///   - country: страна
	///   - completion: блок, который выполнится при завершении выбора города
	func showChangeCityViewController(on viewController: UIViewController,
									  country: CountryModel,
									  completion: @escaping (CityModel) -> Void)

	/// Показывает экран смены страны
	/// - Parameters:
	///   - viewController: контроллер на котором будет показан экран
	///   - completion: блок, который выполнится при завершении выбора страны
	func showChangeCountryViewController(on viewController: UIViewController,
										 completion: @escaping (CountryModel) -> Void)

	/// Показывает алерт с информацией что билетов не нашлось
	/// - Parameter viewController: контроллер на котором показывается алерт
	func showNoTicketsFoundAlert(on viewController: UIViewController)
}

/// Роутер экрана поиска билетов
final class TicketsSearchRouter: TicketsSearchRouterProtocol {
	private let selectCountryAssembly: SelectCountryAssemblyProtocol
	private let selectCityAssembly: SelectCityAssemblyProtocol
	private var changeCityAction: ((CityModel) -> Void)?
	private var changeCountryAction: ((CountryModel) -> Void)?
	private let alertsControllerAssembly: AlertControllerAssemblyProtocol

	/// Инициализатор
	/// - Parameters:
	///   - selectCountryAssembly: сборщик экрана выбора страны
	///   - selectCityAssembly: сборщик экрана выбора города
	init(selectCountryAssembly: SelectCountryAssemblyProtocol,
		 selectCityAssembly: SelectCityAssemblyProtocol,
		 alertsControllerAssembly: AlertControllerAssemblyProtocol) {
		self.selectCityAssembly = selectCityAssembly
		self.selectCountryAssembly = selectCountryAssembly
		self.alertsControllerAssembly = alertsControllerAssembly
	}

	func showChangeCityViewController(on viewController: UIViewController,
									  country: CountryModel,
									  completion: @escaping (CityModel) -> Void) {
		let controller = selectCityAssembly.createController(country: country)
		changeCityAction = completion
		controller.output = self
		viewController.present(controller, animated: true, completion: nil)
	}

	func showChangeCountryViewController(on viewController: UIViewController,
										 completion: @escaping (CountryModel) -> Void) {
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
}

extension TicketsSearchRouter: SelectCityViewControllerOutput {
	func userSelect(city: CityModel) {
		changeCityAction?(city)
		changeCityAction = nil
	}
}

extension TicketsSearchRouter: SelectCountryViewControllerOutput {
	func userSelect(country: CountryModel) {
		changeCountryAction?(country)
		changeCountryAction = nil
	}
}
