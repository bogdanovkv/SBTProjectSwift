//
//  CoordinationComposer.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 02.05.2021.
//  Copyright © 2021 Константин Богданов. All rights reserved.
//

import UIKit

protocol CoordinationLayerComposerProtocol {

}
/// Сборщик слоя навигации
final class CoordinationLayerComposer: CoordinationLayerComposerProtocol {
	private let presentationComposer: PresentationLayerComposerProtocol
	private let mainRouter: RouterProtocol

	init(presentationComposer: PresentationLayerComposerProtocol,
		 rootController: UINavigationController) {
		self.presentationComposer = presentationComposer
		self.mainRouter = Router(navigationController: rootController)
	}

	private func composeSettingsCoordinator(router: RouterProtocol) -> Coordinator<Void, Void> {
		return SettingsCoordinator(router: router,
								   settingsModuleAssemby: presentationComposer.composeSettingsAssembly())
	}

	func composeSelectCountryCoordinator() -> Coordinator<Void, Result<String, Error>> {
		return SelectCountryCoordinator(router: mainRouter,
										selectCountryAssembly: presentationComposer.composeSelectCountryAssembly())
	}

	func composeSelectCityCoordinator() -> Coordinator<String, Result<String, Error>> {
		return SelectCityCoordinator(router: mainRouter,
									 selectCityAssembly: presentationComposer.composeSelectCityAssembly())
	}

	func composeTicketCoordinator() -> Coordinator<TicketPresentationModel, Void> {
		return TicketCoordinator(router: mainRouter, ticketAssembly: presentationComposer.composeTicketAssembly())
	}

	func composeTicketsSearchCoordinator(router: RouterProtocol) -> Coordinator<(cityCode: String, countryCode: String), Void> {
		return TicketsSearchCoordinator(router: router,
										ticketsSearchAssembly: presentationComposer.composeTicketsSearchAssembly(),
										ticketCoordinatorAssembly: composeTicketCoordinator,
										selectCityCoordinatorAssembly: composeSelectCityCoordinator,
										selectCountryCoordinatorAssembly: composeSelectCountryCoordinator,
										alertsControllerAssembly: presentationComposer.composeAlertAssembly())
	}

	func composeTabBarCoordinator() -> Coordinator<(cityCode: String,
												   countryCode: String), Void> {
		let assembly = TabBarCoordinatorAssembly()

		return assembly.createCoordinator(router: mainRouter,
										  searchTicketsCoordinatorAssembly: composeTicketsSearchCoordinator(router:),
										  settingsCoordinatorAssembly: composeSettingsCoordinator(router:))
	}

	func composeLocationCoordinator() -> Coordinator<Void, Void> {
		return LocationCoordinator(locationModuleAssembly: presentationComposer.composeLocationAssembly(),
								   router: mainRouter,
								   alertsAssembly: presentationComposer.composeAlertAssembly(),
								   selectCityCoordinatorAssembly: composeSelectCityCoordinator,
								   selectCountryCoordinatorAssembly: composeSelectCountryCoordinator,
								   tabBarCoordinatorAssembly: composeTabBarCoordinator)
	}
}
