//
//  LocationRouter.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 02.11.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import UIKit

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
	func showSelectCityController(with country: CountryModel,
								  on controller: UIViewController & SelectCityViewControllerOutput)
}

final class LocationRouter: LocationRouterProtocol {
	private let alertAssembly: AlertControllerAssemblyProtocol
	private let selectCountryAssembly: SelectCountryAssemblyProtocol
	private let selectCityAssembly: SelectCityAssemblyProtocol

	init(alertAssembly: AlertControllerAssemblyProtocol,
		 selectCountryAssembly: SelectCountryAssemblyProtocol,
		 selectCityAssembly: SelectCityAssemblyProtocol) {
		self.alertAssembly = alertAssembly
		self.selectCountryAssembly = selectCountryAssembly
		self.selectCityAssembly = selectCityAssembly
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
			controller?.retryGetLoaction()
		})
		let repeatAction = UIAlertAction(title: "Повторить", style: .default, handler: { [weak controller] _ in
			controller?.presentedViewController?.dismiss(animated: true, completion: nil)
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

	func showSelectCityController(with country: CountryModel,
								  on controller: UIViewController & SelectCityViewControllerOutput) {
		let selectCountryController = selectCityAssembly.createController(country: country)
		selectCountryController.output = controller
		controller.present(selectCountryController, animated: true, completion: nil)
	}
}
