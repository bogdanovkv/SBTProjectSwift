//
//  LocationInteractor.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 24.10.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import Foundation
import LocationDomainAbstraction
import DomainAbstraction

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
	func didRecieve(city: City)

	/// Получена страна
	/// - Parameter country: страна
	func didRecieve(country: Country)
}

/// Интерактор экрана выбора метоположения
final class LocationInteractor: LocationInteractorInput {

	weak var ouptput: LocationInteractorOutput?

	private let getLocationUseCase: UseCase<Void, Location>
	private let prepareStorageUseCase: UseCase<Void, Void>
	private let getCountryUseCase: UseCaseSync<String, Country?>
	private let getCityUseCase: UseCaseSync<String, City?>

	/// Инициализатор
	/// - Parameters:
	///   - getLocationUseCase: кейс получения местоположения
	///   - getCountryUseCase: кейс получения страны
	///   - getCityUseCase: кейст получения города
	///   - prepareStorageUseCase: кейс подготовки хранилища
	init(getLocationUseCase: UseCase<Void, Location>,
		 getCountryUseCase: UseCaseSync<String, Country?>,
		 getCityUseCase: UseCaseSync<String, City?>,
		 prepareStorageUseCase: UseCase<Void, Void>) {
		self.getLocationUseCase = getLocationUseCase
		self.getCountryUseCase = getCountryUseCase
		self.getCityUseCase = getCityUseCase
		self.prepareStorageUseCase = prepareStorageUseCase
	}

	func getLocation() {
		getLocationUseCase.execute(parameter: ()) { [weak self] result in
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
		prepareStorageUseCase.execute(parameter: ()) { [weak self] result in
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
		if let city = getCityUseCase.execute(parameter: name) {
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
		if let country = getCountryUseCase.execute(parameter: name) {
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
