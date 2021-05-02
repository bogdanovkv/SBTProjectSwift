//
//  TicketCoordinator.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 02.05.2021.
//  Copyright © 2021 Константин Богданов. All rights reserved.
//

import UIKit

final class TicketCoordinator: Coordinator<TicketPresentationModel, Void> {

	private let router: RouterProtocol
	private let ticketAssembly: TicketAssemblyProtocol

	private var ticketModule: TicketModuleInput?

	init(router: RouterProtocol, ticketAssembly: TicketAssemblyProtocol) {
		self.router = router
		self.ticketAssembly = ticketAssembly
	}

	override func start(parameter: TicketPresentationModel) {
		var module = ticketAssembly.createViewCotroller(for: parameter)
		module.moduleOutput = self
		router.push(module)
	}
}

extension TicketCoordinator: TicketModuleOutput {
	func cannotFindFromCityForCodeInTicker() {

	}

	func cannotFindFromCountryForCodeInTicker() {

	}

	func cannotFindToCityForCodeInTicker() {

	}

	func cannotFindToCountryForCodeInTicker() {

	}
}
