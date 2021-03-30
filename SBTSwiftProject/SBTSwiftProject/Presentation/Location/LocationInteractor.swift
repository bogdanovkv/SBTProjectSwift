//
//  LocationInteractor.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 24.10.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import Foundation

/// Протокол интерактор экрана выбора метоположения
protocol LocationInteractorInput: AnyObject {

	/// Получить местоположение пользователя.
	func getLocation()

	/// Подготовить хранилище
	func prepareStorage()
}

/// Интерактор экрана выбора метоположения
protocol LocationInteractorOutput: AnyObject {

	///  Не удалось получить локацию пользователя
	func didRecieveLocationError()

	/// Не удалось подготовить хранилище с городами, странами и аэропортами для приложения
	func didPrepareStorage()

	/// Получена ошибка при подготовке хранилища
	func didRecievePrepareStorageError()

	/// Получен город
	/// - Parameter city: город
	func didRecieve(city: CityModel)

	/// Получена страна
	/// - Parameter country: страна
	func didRecieve(country: CountryModel)
}

/// Интерактор экрана выбора метоположения
final class LocationInteractor: LocationInteractorInput {

	weak var ouptput: LocationInteractorOutput?

	private let getLocationUseCase: LocationUseCaseProtocol
	private let prepareStorageUseCase: PrepareStorageUseCaseProtocol

	init(getLocationUseCase: LocationUseCaseProtocol,
		 prepareStorageUseCase: PrepareStorageUseCaseProtocol) {
		self.getLocationUseCase = getLocationUseCase
		self.prepareStorageUseCase = prepareStorageUseCase
	}

	func getLocation() {
		getLocationUseCase.getLocation { [weak self] result in
			guard let location = try? result.get() else {
				DispatchQueue.main.async {
					self?.ouptput?.didRecieveLocationError()
				}
				return
			}
			self?.getCity(wint: location.city)
			self?.getCountry(with: location.country)
		}
	}

	func prepareStorage() {
		prepareStorageUseCase.prepareStorage { [weak self] result in
			do {
				_ = try result.get()
				DispatchQueue.main.async {
					self?.ouptput?.didPrepareStorage()
				}
			} catch {
				DispatchQueue.main.async {
					self?.ouptput?.didRecievePrepareStorageError()
				}
			}
		}
	}

	func getCity(wint name: String) {
		if let city = getLocationUseCase.getCity(named: name) {
			DispatchQueue.main.async { [weak self] in
				self?.ouptput?.didRecieve(city: city)
			}
			return
		}
		DispatchQueue.main.async { [weak self] in
			self?.ouptput?.didRecieveLocationError()
		}
	}

	func getCountry(with name: String) {
		if let country = getLocationUseCase.getCountry(named: name) {
			DispatchQueue.main.async { [weak self] in
				self?.ouptput?.didRecieve(country: country)
			}
			return
		}
		DispatchQueue.main.async { [weak self] in
			self?.ouptput?.didRecieveLocationError()
		}
	}
}
