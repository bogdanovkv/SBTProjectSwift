//
//  TabBarCoordinator.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 01.05.2021.
//  Copyright © 2021 Константин Богданов. All rights reserved.
//

import UIKit

final class TabBarCoordinator: Coordinator<(cityCode: String,
											countryCode: String), Void> {
	private let searchTicketsCoordinatorAssembly: () -> Coordinator<(cityCode: String,
																										 countryCode: String), Void>

	private let settingsCoordinatorAssembly: () -> Coordinator<Void, Void>
	private var settingsCoordinator: Coordinator<Void, Void>?
	private var searchTicketsCoordinator: Coordinator<(cityCode: String,
													   countryCode: String), Void>?
	/// Инициализатор
	/// - Parameters:
	///   - searchTicketsCoordinatorAssembly: сбощик координатора
	///   - settingsCoordinatorAssembly: сборщик координатора настроке
	init(searchTicketsCoordinatorAssembly: @escaping () -> Coordinator<(cityCode: String,
																			  countryCode: String), Void>,
		 settingsCoordinatorAssembly: @escaping () -> Coordinator<Void, Void>) {
		self.searchTicketsCoordinatorAssembly = searchTicketsCoordinatorAssembly
		self.settingsCoordinatorAssembly = settingsCoordinatorAssembly
	}

	override func start(parameter: (cityCode: String,
									countryCode: String)) {
		startSettings()
		startSearchTickets(parameter: parameter)
	}

	private func startSettings() {
		let settingsCoordinator = settingsCoordinatorAssembly()
		self.settingsCoordinator = settingsCoordinator
		settingsCoordinator.finishFlow = { [weak self] _ in
			self?.settingsCoordinator = nil
		}
		settingsCoordinator.start()
	}

	private func startSearchTickets(parameter: (cityCode: String,
												countryCode: String)) {
		let searchTicketsCoordinator = searchTicketsCoordinatorAssembly()
		self.searchTicketsCoordinator = searchTicketsCoordinator
		searchTicketsCoordinator.finishFlow = { [weak self] _ in
			self?.searchTicketsCoordinator = nil
		}
		searchTicketsCoordinator.start(parameter: parameter)
	}
}
