//
//  TicketsSearchCoordinator.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 01.05.2021.
//  Copyright © 2021 Константин Богданов. All rights reserved.
//

import UIKit

final class TicketsSearchCoordinator: Coordinator<(cityCode: String, countryCode: String), Void> {

	private let router: RouterProtocol
	private let ticketsSearchAssembly: TicketsSearchAssemblyProtocol
	private var ticketsSearchModule: TicketsSearchModuleInput?
	private let ticketCoordinatorAssembly: () -> Coordinator<TicketPresentationModel, Void>
	private let selectCityCoordinatorAssembly: () -> Coordinator<String, Result<String, Error>>
	private let selectCountryCoordinatorAssembly: () -> Coordinator<Void, Result<String, Error>>
	private let alertsControllerAssembly: AlertControllerAssemblyProtocol

	private var ticketCoordinator: Coordinator<TicketPresentationModel, Void>?
	private var selectCityCoordinator: Coordinator<String, Result<String, Error>>?
	private var selectCountryCoordinator: Coordinator<Void, Result<String, Error>>?

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
		 ticketCoordinatorAssembly: @escaping () -> Coordinator<TicketPresentationModel, Void>,
		 selectCityCoordinatorAssembly: @escaping () -> Coordinator<String, Result<String, Error>>,
		 selectCountryCoordinatorAssembly: @escaping () -> Coordinator<Void, Result<String, Error>>,
		 alertsControllerAssembly: AlertControllerAssemblyProtocol) {
		self.router = router
		self.ticketCoordinatorAssembly = ticketCoordinatorAssembly
		self.ticketsSearchAssembly = ticketsSearchAssembly
		self.selectCityCoordinatorAssembly = selectCityCoordinatorAssembly
		self.selectCountryCoordinatorAssembly = selectCountryCoordinatorAssembly
		self.alertsControllerAssembly = alertsControllerAssembly
		super.init()
	}

	override func start(parameter: (cityCode: String, countryCode: String)) {
		var ticketsSearchModule = ticketsSearchAssembly.createViewController(with: parameter.cityCode,
																			 coutryCode: parameter.countryCode)
		self.ticketsSearchModule = ticketsSearchModule
		ticketsSearchModule.moduleOutput = self
		router.push(ticketsSearchModule)
	}
}

extension TicketsSearchCoordinator: TicketsSearchModuleOutput {
	func userSelectChangeDepartureLocation() {
		let selectCountryCoordinator = selectCountryCoordinatorAssembly()
		self.selectCountryCoordinator = selectCountryCoordinator
		selectCountryCoordinator.finishFlow = { [weak self] result in
			self?.selectCountryCoordinator = nil
			switch result {
			case .success(let code):
				self?.ticketsSearchModule?.changeDepartureCountry(with: code)
			case .failure:
				break
			}
		}
		selectCountryCoordinator.start()
	}

	func userSelectChangeDestinationLocation() {
		let selectCountryCoordinator = selectCountryCoordinatorAssembly()
		self.selectCountryCoordinator = selectCountryCoordinator
		selectCountryCoordinator.finishFlow = { [weak self] result in
			self?.selectCountryCoordinator = nil
			switch result {
			case .success(let code):
				self?.ticketsSearchModule?.changeDestinationCountry(with: code)
			case .failure:
				break
			}
		}
		selectCountryCoordinator.start()
	}

	func userSelectChangeDestinationCity(for code: String) {
		let selectCityCoordinator = selectCityCoordinatorAssembly()
		self.selectCityCoordinator = selectCityCoordinator
		selectCityCoordinator.finishFlow = { [weak self] result in
			self?.selectCityCoordinator = nil
			switch result {
			case .success(let code):
				self?.ticketsSearchModule?.changeDesinationCity(with: code)
			case .failure:
				break
			}
		}
		selectCityCoordinator.start(parameter: code)
	}

	func userSelectChangeDepartureCity(for code: String) {
		let selectCityCoordinator = selectCityCoordinatorAssembly()
		self.selectCityCoordinator = selectCityCoordinator
		selectCityCoordinator.finishFlow = { [weak self] result in
			self?.selectCityCoordinator = nil
			switch result {
			case .success(let code):
				self?.ticketsSearchModule?.changeDepartureCity(with: code)
			case .failure:
				break
			}
		}
		selectCityCoordinator.start(parameter: code)
	}

	func userSelectTicket(_ ticket: TicketPresentationModel) {
		let ticketCoordinator = ticketCoordinatorAssembly()
		self.ticketCoordinator = ticketCoordinator
		ticketCoordinator.finishFlow = { [weak self] _ in
			self?.ticketCoordinator = nil
		}

		ticketCoordinator.start(parameter: ticket)
	}

	func somethingWentWrong() {
		let alert = alertsControllerAssembly.createController(title: "Что-то пошло не так...",
															  message: "Всякое бывает",
															  preferredStyle: .alert,
															  actions: [.init(title: "Закрыть",
																			  style: .cancel,
																			  handler: { [weak self] _ in
																				self?.router.dismiss(nil)
																			  })])
		router.present(alert)
	}

	func noTicketsWereFound() {
		let alert = alertsControllerAssembly.createController(title: "Билетов не нашлось :-(",
															  message: "К сожалению, по вашему запросу нет билетов. Попробуйте изменить параметры поиска или сидите дома.",
															  preferredStyle: .alert,
															  actions: [.init(title: "Закрыть",
																			  style: .cancel,
																			  handler: { [weak self] _ in
																				self?.router.dismiss(nil)
																			  })])
		router.present(alert)
	}
}
