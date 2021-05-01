//
//  LocationRouter.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 02.11.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import UIKit
import LocationDomainAbstraction

/// Протокол роутера экрана выбора местоположения
protocol LocationRouterProtocol {

	/// Показывает алерт об ошибке получения стран, городов и аэропортов
	/// - Parameter controller: контроллер на котором будет показан алерт
	func showStorageErrorAlert(on controller: UIViewController & LocationViewControllerInput)

	/// Показывает алерт
	/// - Parameter controller: алерт на котором будет показан алерт
	func showLocationErrorAlert(on controller: UIViewController & LocationViewControllerInput)

	/// Показывает экран выбора страны на переданном контроллере
	/// - Parameter controller: контроллер
	func showSelectCountryController(on controller: UIViewController & SelectCountryViewControllerOutput)

	/// Показывает экран выбора города на переданном контроллере
	/// - Parameter controller: контроллер
	func showSelectCityController(with countryCode: String,
								  on controller: UIViewController & SelectCityViewControllerOutput)

	/// Открывает таб бар с поиском билетов, сохраненными билетами и настройками
	/// - Parameters:
	///   - city: город
	///   - country: страна
	///   - controller: контроллер на который покажется таб бар
	func openTabBarViewController(with city: City,
								  country: Country,
								  on controller: UIViewController)
}

/// Роутер экрана выбора местоположения
final class LocationRouter: LocationRouterProtocol {
	private let alertAssembly: AlertControllerAssemblyProtocol
	private let selectCountryAssembly: SelectCountryAssemblyProtocol
	private let selectCityAssembly: SelectCityAssemblyProtocol
	private let tabBarAssembly: TabBarAssemblyProtocol

	/// Инициализатор
	/// - Parameters:
	///   - alertAssembly: сборщик алертов
	///   - selectCountryAssembly: сборщик экрана выбора страны
	///   - selectCityAssembly: сборщик экрана выбора города
	///   - tabBarAssembly: сборщик таб бара
	init(alertAssembly: AlertControllerAssemblyProtocol,
		 selectCountryAssembly: SelectCountryAssemblyProtocol,
		 selectCityAssembly: SelectCityAssemblyProtocol,
		 tabBarAssembly: TabBarAssemblyProtocol) {
		self.alertAssembly = alertAssembly
		self.selectCountryAssembly = selectCountryAssembly
		self.selectCityAssembly = selectCityAssembly
		self.tabBarAssembly = tabBarAssembly
	}

	func showStorageErrorAlert(on controller: UIViewController & LocationViewControllerInput) {

		let action = UIAlertAction(title: "Повторить", style: .default, handler: { [weak controller] _ in
			controller?.presentedViewController?.dismiss(animated: true, completion: nil)
			controller?.retryPrepareStorage()
		})
		let alert = alertAssembly.createController(title: "Не удалось получить данные :(",
												   message: "Не удалось загрузить данные по странам, городам и аэропортам. Попробуйте повторить попытку позже.",
												   preferredStyle: .alert,
												   actions: [action])
		controller.present(alert, animated: true, completion: nil)
	}

	func showLocationErrorAlert(on controller: UIViewController & LocationViewControllerInput) {
		let manualAction = UIAlertAction(title: "Выбрать вручную", style: .cancel, handler: { [weak controller] _ in
			controller?.presentedViewController?.dismiss(animated: true, completion: nil)
		})
		let repeatAction = UIAlertAction(title: "Повторить", style: .default, handler: { [weak controller] _ in
			controller?.presentedViewController?.dismiss(animated: true, completion: nil)
			controller?.retryGetLoaction()
		})
		let alert = alertAssembly.createController(title: "Не удалось получить данные :(",
												   message: "Не удалось получить ваше местоположение, повторите попытку или выберите его самостоятельно.",
												   preferredStyle: .alert,
												   actions: [manualAction, repeatAction])
		controller.present(alert, animated: true, completion: nil)
	}

	func showSelectCountryController(on controller: UIViewController & SelectCountryViewControllerOutput) {
		let selectCountryController = selectCountryAssembly.createController()
		selectCountryController.output = controller
		controller.present(selectCountryController, animated: true, completion: nil)
	}

	func showSelectCityController(with countryCode: String,
								  on controller: UIViewController & SelectCityViewControllerOutput) {
		let selectCountryController = selectCityAssembly.createController(countryCode: countryCode)
		selectCountryController.output = controller
		controller.present(selectCountryController, animated: true, completion: nil)
	}

	func openTabBarViewController(with city: City, country: Country, on controller: UIViewController) {
		let tabBarController = tabBarAssembly.createController(with: city, coutry: country)
		tabBarController.modalPresentationStyle = .fullScreen
		controller.present(tabBarController, animated: true, completion: nil)
	}
}
