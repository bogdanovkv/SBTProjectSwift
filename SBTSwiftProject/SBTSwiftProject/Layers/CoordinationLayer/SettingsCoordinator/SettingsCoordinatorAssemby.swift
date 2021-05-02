//
//  SettingsCoordinatorAssemby.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 02.05.2021.
//  Copyright © 2021 Константин Богданов. All rights reserved.
//

import UIKit

/// Сборщик координатора экрана настроек
protocol SettingsCoordinatorAssembyProtocol {
	func createCoordinator(router: RouterProtocol,
						   settingsModuleAssemby: SettingsAssemblyProtocol) -> Coordinator<Void, Void>
}

/// Сборщик координатора экрана настроек
final class SettingsCoordinatorAssemby: SettingsCoordinatorAssembyProtocol {
	func createCoordinator(router: RouterProtocol,
						   settingsModuleAssemby: SettingsAssemblyProtocol) -> Coordinator<Void, Void> {
		return SettingsCoordinator(router: router, settingsModuleAssemby: settingsModuleAssemby)
	}
}
