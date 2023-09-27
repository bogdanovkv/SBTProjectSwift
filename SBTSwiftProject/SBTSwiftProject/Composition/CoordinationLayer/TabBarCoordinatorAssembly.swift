//
//  TabBarCoordinatorAssembly.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 01.05.2021.
//  Copyright © 2021 Константин Богданов. All rights reserved.
//

import UIKit

/// Сбощик координатора таб бараПриложения
protocol TabBarCoordinatorAssemblyProtocol {

	/// Создает координатор
	/// - Parameters:
	///   - router: роутер
	///   - cityCode: код города
	///   - countryCode: код страны
	func createCoordinator(router: RouterProtocol,
						   searchTicketsCoordinatorAssembly: @escaping (RouterProtocol) -> Coordinator<(cityCode: String,
																										countryCode: String), Void>,
						  settingsCoordinatorAssembly: @escaping (RouterProtocol) -> Coordinator<Void, Void>) -> Coordinator<(cityCode: String, countryCode: String), Void>
}

class TabBarCoordinatorAssembly: TabBarCoordinatorAssemblyProtocol {

	func createCoordinator(router: RouterProtocol,
						   searchTicketsCoordinatorAssembly: @escaping (RouterProtocol) -> Coordinator<(cityCode: String,
																										countryCode: String), Void>,
						   settingsCoordinatorAssembly: @escaping (RouterProtocol) -> Coordinator<Void, Void>) -> Coordinator<(cityCode: String, countryCode: String), Void> {
		let tabBarController = UITabBarController()
		let navigationController = UINavigationController(rootViewController: tabBarController)
		navigationController.isNavigationBarHidden = true
		let searchTicketsNavigationController = UINavigationController()
		let searchTicketsRouter = Router(navigationController: searchTicketsNavigationController)

		let settingsNavigationController = UINavigationController()
		let settingsRouter = Router(navigationController: settingsNavigationController)

		tabBarController.setViewControllers([searchTicketsNavigationController,
											 settingsNavigationController],
											animated: true)
		return TabBarCoordinator(router: router,
								 searchTicketsCoordinatorAssembly: { () -> Coordinator<(cityCode: String, countryCode: String), Void> in
			return searchTicketsCoordinatorAssembly(searchTicketsRouter)
		}, settingsCoordinatorAssembly: { () -> Coordinator<Void, Void> in
			return settingsCoordinatorAssembly(settingsRouter)
		}, tabBarAssembly: {
			return navigationController
		})
	}
}
