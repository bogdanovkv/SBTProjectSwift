//
//  LocationAssembly.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 24.10.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import DomainAbstraction
import LocationDomainAbstraction
import UIKit

/// Сборщик экрана выбора местоположения пользоателя
protocol LocationAssemblyProtocol {
	/// Создает контроллер
	/// - Returns: контроллер
	func createController() -> UIViewController & LocationModuleInput
}

/// Сборщик экрана выбора местоположения пользоателя
final class LocationAssembly: LocationAssemblyProtocol {

	private let getLocationUseCase: UseCase<Void, Location>
	private let prepareStorageUseCase: UseCase<Void, Void>
	private let getCountryUseCase: UseCaseSync<String, Country?>
	private let getCityUseCase: UseCaseSync<String, City?>
	private let getCityByCodeUseCase: UseCaseSync<String, City?>
	private let getCountryByCodeUseCase: UseCaseSync<String, Country?>

	/// Инициализатор
	/// - Parameters:
	///   - getLocationUseCase: кейс получения местоположения
	///   - getCountryUseCase: кейс получения страны
	///   - getCityUseCase: кейст получения города
	///   - prepareStorageUseCase: кейс подготовки хранилища
	init(getLocationUseCase: UseCase<Void, Location>,
		 getCountryUseCase: UseCaseSync<String, Country?>,
		 getCityUseCase: UseCaseSync<String, City?>,
		 prepareStorageUseCase: UseCase<Void, Void>,
		 getCityByCodeUseCase: UseCaseSync<String, City?>,
		 getCountryByCodeUseCase: UseCaseSync<String, Country?>) {
		self.getLocationUseCase = getLocationUseCase
		self.getCountryUseCase = getCountryUseCase
		self.getCityUseCase = getCityUseCase
		self.prepareStorageUseCase = prepareStorageUseCase
		self.getCityByCodeUseCase = getCityByCodeUseCase
		self.getCountryByCodeUseCase = getCountryByCodeUseCase
	}

	func createController() -> UIViewController & LocationModuleInput {
		let interactor = LocationInteractor(getLocationUseCase: getLocationUseCase,
											getCountryUseCase: getCountryUseCase,
											getCityUseCase: getCityUseCase,
											prepareStorageUseCase: prepareStorageUseCase,
											getCityByCodeUseCase: getCityByCodeUseCase,
											getCountryByCodeUseCase: getCountryByCodeUseCase)
		let locationController = LocationViewController(interactor: interactor)
		interactor.ouptput = locationController
		return locationController
	}
}
