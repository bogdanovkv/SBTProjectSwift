//
//  LocationAssembly.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 24.10.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import UIKit

/// Сборщик экрана выбора местоположения пользоателя
protocol LocationAssemblyProtocol {
	/// Создает контроллер
	/// - Returns: контроллер
	func createController() -> UIViewController & LocationModuleInput
}

/// Сборщик экрана выбора местоположения пользоателя
final class LocationAssembly {

	func createController() -> UIViewController & LocationModuleInput {
		let interactor = LocationInteractor(getLocationUseCase: DomainLayerDependencies.createLocationUseCase(),
											getCountryUseCase: DomainLayerDependencies.createGetCountryByNameUseCase(),
											getCityUseCase: DomainLayerDependencies.createGetCityByNameUseCase(),
											prepareStorageUseCase: DomainLayerDependencies.createPrepareStorageUseCase(),
											getCityByCodeUseCase: DomainLayerDependencies.createGetCityByCodeUseCase(),
											getCountryByCodeUseCase: DomainLayerDependencies.createGetCountryByCodeUseCase())
		let locationController = LocationViewController(interactor: interactor)
		interactor.ouptput = locationController
		return locationController
	}
}
