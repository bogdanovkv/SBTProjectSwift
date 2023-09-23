//
//  LocationAssembly.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 24.10.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import DomainAbstractions
import LocationDomain
import LocationDomainModels
import UIKit

/// Сборщик экрана выбора местоположения пользоателя
protocol LocationAssemblyProtocol {
	/// Создает контроллер
	/// - Returns: контроллер
	func createController() -> UIViewController & LocationModuleInput
}

/// Сборщик экрана выбора местоположения пользоателя
final class LocationAssembly: LocationAssemblyProtocol {

	private let getLocationUseCase: any UseCaseAsync<Void, Result<Location, Error>>
	private let prepareStorageUseCase: any UseCaseAsync<Void, Result<Void, Error>>
	private let getCountryUseCase: any UseCase<String, Country?>
	private let getCityUseCase: any UseCase<String, City?>
	private let getCityByCodeUseCase: any UseCase<String, City?>
	private let getCountryByCodeUseCase: any UseCase<String, Country?>

	/// Инициализатор
	/// - Parameters:
	///   - getLocationUseCase: кейс получения местоположения
	///   - getCountryUseCase: кейс получения страны
	///   - getCityUseCase: кейст получения города
	///   - prepareStorageUseCase: кейс подготовки хранилища
	init(getLocationUseCase: any UseCaseAsync<Void, Result<Location, Error>>,
		 getCountryUseCase: any UseCase<String, Country?>,
		 getCityUseCase: any UseCase<String, City?>,
		 prepareStorageUseCase: any UseCaseAsync<Void, Result<Void, Error>>,
		 getCityByCodeUseCase: any UseCase<String, City?>,
		 getCountryByCodeUseCase: any UseCase<String, Country?>) {
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
		interactor.output = LocationInteractorOutputMainThreadProxy(output: locationController)
		return locationController
	}
}
