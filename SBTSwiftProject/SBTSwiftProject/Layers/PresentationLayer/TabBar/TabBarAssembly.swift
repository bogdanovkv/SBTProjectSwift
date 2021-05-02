//
//  TabBarAssembly.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 06.11.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import UIKit
import LocationDomainAbstraction

/// Протокол сборщика ТабБара
protocol TabBarAssemblyProtocol {

	/// Создает контроллер
	/// - Parameters:
	///   - city: модель города
	///   - coutry: модель страны
	func createController(with cityCode: String,
						  coutryCode: String) -> UIViewController
}


/// Сборщик ТабБара
final class TabBarAssembly: TabBarAssemblyProtocol {

	private let ticketsSearchAssembly: TicketsSearchAssemblyProtocol
	private let settingsAssembly: SettingsAssemblyProtocol

	/// Инициализатор
	/// - Parameters:
	///   - ticketsSearchAssembly: сбощик экрана поиска билетов
	///   - settingsAssembly: сборщик экрана настроек
	init(ticketsSearchAssembly: TicketsSearchAssemblyProtocol,
		 settingsAssembly: SettingsAssemblyProtocol) {
		self.ticketsSearchAssembly = ticketsSearchAssembly
		self.settingsAssembly = settingsAssembly
	}

	func createController(with cityCode: String, coutryCode: String) -> UIViewController {

		let tabBarController = UITabBarController()
		let ticketsSearchViewController = ticketsSearchAssembly.createViewController(with: cityCode,
																					 coutryCode: coutryCode)
		let settingsViewController = settingsAssembly.createViewController()
		tabBarController.setViewControllers([ticketsSearchViewController, settingsViewController],
											animated: true)
		return tabBarController
	}
}