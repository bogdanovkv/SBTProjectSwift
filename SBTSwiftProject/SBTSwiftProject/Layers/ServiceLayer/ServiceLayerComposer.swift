//
//  ServiceLayerComposer.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 02.05.2021.
//  Copyright © 2021 Константин Богданов. All rights reserved.
//

import DatabaseAbstraction
import CoreDataService
import NetworkAbstraction
import NetworkService
import UserSettingsAbstration
import UserSettingsService
import Foundation

/// Сборщик сервисного слоя
protocol ServiceLayerComposerProtocol {

	/// Собирает сервис работы с сетью
	func composeNetworkService() -> NetworkServiceProtocol

	/// Собирает сервис работу с БД
	func composeDatabaseService() -> DatabaseServiceProtocol

	/// Собирает сервис хранения пользовательских настроек
	func composeUserSettings() -> UserSettingsServiceProtocol
}

final class ServiceLayerComposer: ServiceLayerComposerProtocol {

	private lazy var coreDataAssembly = CoreDataServiceAssembly()

	func composeNetworkService() -> NetworkServiceProtocol {
		return NetworkService()
	}

	func composeDatabaseService() -> DatabaseServiceProtocol {
		let service = coreDataAssembly.createCoreDataService()
		return service
	}

	func composeUserSettings() -> UserSettingsServiceProtocol {
		return UserSettingsService(userDefaults: UserDefaults.standard)
	}
}
