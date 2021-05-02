//
//  TicketsSearchCoordinator.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 01.05.2021.
//  Copyright © 2021 Константин Богданов. All rights reserved.
//

import UIKit

final class TicketsSearchCoordinator: Coordinator<Void, Void> {

	private let router: RouterProtocol
	private let ticketsSearchAssembly: TicketsSearchAssemblyProtocol
	private var ticketCoordinator: Coordinator<Void, Void>?
	private var ticketsSearchModule: TicketsSearchModuleInput?
	private let ticketCoordinatorAssembly: (TicketPresentationModel) -> Coordinator<Void, Void>
	private let cityCode: String
	private let countryCode: String

	/// Инициаизатор
	/// - Parameters:
	///   - router: роутер
	///   - ticketCoordinator: координатор информации о билете
	///   - ticketsSearchAssembly: сборщик экрана информации о билете
	///   - ticketCoordinatorAssembly: координатор
	///   - cityCode: код города
	///   - countryCode: код страны
	init(router: RouterProtocol,
		 ticketsSearchAssembly: TicketsSearchAssemblyProtocol,
		 ticketCoordinatorAssembly: @escaping (TicketPresentationModel) -> Coordinator<Void, Void>,
		 cityCode: String,
		 countryCode: String) {
		self.router = router
		self.ticketCoordinatorAssembly = ticketCoordinatorAssembly
		self.ticketsSearchAssembly = ticketsSearchAssembly
		self.cityCode = cityCode
		self.countryCode = countryCode
		super.init()
	}

	override func start(parameter: Void) {
		let ticketsSearchModule = ticketsSearchAssembly.createViewController(with: cityCode, coutryCode: countryCode)
		self.ticketsSearchModule = ticketsSearchModule
		router.push(ticketsSearchModule)
	}
}
