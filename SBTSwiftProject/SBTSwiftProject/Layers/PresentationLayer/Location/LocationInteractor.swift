//
//  LocationInteractor.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 24.10.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import Foundation
import LocationDomain
import DomainAbstractions
import LocationDomainModels

/// Протокол интерактор экрана выбора метоположения
protocol LocationInteractorInput: AnyObject {

	/// Получить местоположение пользователя.
	func getLocation()

	/// Подготовить хранилище
	func prepareStorage()

	/// Получат город по коду
	/// - Parameter code: код города
	func getCity(code: String) -> City?

	/// Получает страну по коду
	/// - Parameter code: код
	func getCountry(code: String) -> Country?
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

	var output: LocationInteractorOutput?

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

	func getLocation() {
		Task {
			guard let location = try? await getLocationUseCase.execute(input: ()).get() else {
				self.output?.didRecieveLocationError()
				return
			}
			self.getCity(wint: location.city)
			self.getCountry(with: location.country)
		}
	}

	func prepareStorage() {
		Task {
			do {
				_ = try await prepareStorageUseCase.execute(input: ()).get()
				self.output?.didPrepareStorage()
			} catch {
				DispatchQueue.main.async {
					self.output?.didRecievePrepareStorageError()
				}
			}
		}
	}

	func getCity(wint name: String) {
		if let city = getCityUseCase.execute(input: name) {
				self.output?.didRecieve(city: city)
			return
		}
		self.output?.didRecieveLocationError()
	}

	func getCountry(with name: String) {
		if let country = getCountryUseCase.execute(input: name) {
			output?.didRecieve(country: country)
			return
		}
		output?.didRecieveLocationError()
	}

	func getCity(code: String) -> City? {
		return getCityByCodeUseCase.execute(input: code)
	}

	func getCountry(code: String) -> Country? {
		return getCountryByCodeUseCase.execute(input: code)
	}
}
