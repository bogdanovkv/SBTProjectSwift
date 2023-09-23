//
//  ServiceLayerComposer.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 02.05.2021.
//  Copyright © 2021 Константин Богданов. All rights reserved.
//

import DatabaseAbstraction
import CoreDataService
import NetworkingAbstractions
import NetworkService
import UserSettingsService
import UserSettingsRepository
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

	private lazy var coreData = CoreDataServiceAssembly.createCoreDataService()

	func composeNetworkService() -> NetworkServiceProtocol {
		return NetworkService()
	}

	func composeDatabaseService() -> DatabaseServiceProtocol {
		return coreData
	}

	func composeUserSettings() -> UserSettingsServiceProtocol {
		return UserSettingsService(userDefaults: UserDefaults.standard)
	}
}
