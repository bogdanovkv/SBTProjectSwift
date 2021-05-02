//
//  SettingsCoordinator.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 02.05.2021.
//  Copyright © 2021 Константин Богданов. All rights reserved.
//

import UIKit

/// Координатор экрана настроек
final class SettingsCoordinator: Coordinator<Void, Void> {

	private let settingsModuleAssemby: SettingsAssemblyProtocol
	private let router: RouterProtocol
	private var settingsModule: SettingsModuleInput?

	/// Инициализатор
	/// - Parameter settingsModuleAssemby: сборщик экрана настроек
	init(router: RouterProtocol,
		 settingsModuleAssemby: SettingsAssemblyProtocol) {
		self.settingsModuleAssemby = settingsModuleAssemby
		self.router = router
	}

	override func start(parameter: Void) {
		var module = settingsModuleAssemby.createViewController()
		self.settingsModule = module
		module.moduleOutput = self
		router.push(module)
	}
}

extension SettingsCoordinator: SettingsModuleOuput {

}
