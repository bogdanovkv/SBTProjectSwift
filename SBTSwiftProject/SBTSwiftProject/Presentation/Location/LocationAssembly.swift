//
//  LocationAssembly.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 24.10.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import UIKit

/// Сборщик экрана выбора местоположения пользоателя
final class LocationAssembly {

	/// Создает контроллер
	/// - Returns: контроллер
	func createController() -> UIViewController {
		let interactor = LocationInteractor(getLocationUseCase: DomainLayerDependencies.createLocationUseCase(),
											getCountryUseCase: DomainLayerDependencies.createGetCountryUseCase(),
											getCityUseCase: DomainLayerDependencies.createGetCityUseCase(),
											prepareStorageUseCase: DomainLayerDependencies.createPrepareStorageUseCase())
		let tabBarAssembly = TabBarAssembly(ticketsSearchAssembly: TicketsSearchAssembly(),
											settingsAssembly: SettingsAssembly())
		let router = LocationRouter(alertAssembly: AlertControllerAssembly(),
									selectCountryAssembly: SelectCountryAssembly(),
									selectCityAssembly: SelectCityAssembly(),
									tabBarAssembly: tabBarAssembly)
		let locationController = LocationViewController(interactor: interactor,
														router: router)
		interactor.ouptput = locationController
		return locationController
	}
}
