//
//  ViewController.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 14.07.2018.
//  Copyright © 2018 Константин Богданов. All rights reserved.
//

import UIKit
import LocationDomain
import LocationDomainModels

protocol LocationModuleOutput {

	/// Экрану не удалось подготовить хранилище
	func moduleDidRecievePrepareStorageError()

	/// Получена ошибка при определении местоположения
	func moduleDidRecieveLocationError()

	/// Показывает экран выбора города на переданном контроллере
	/// - Parameter controller: контроллер
	func userSelectChangeCity(for countryCode: String)

	/// Показывает экран выбора страны на переданном контроллере
	/// - Parameter controller: контроллер
	func userSelectChangeCountry()

	/// Пользователь выбрал местоположение
	func userSelectLocation(with cityCode: String, countryCode: String)
}

/// Протокол контроллера выбора местоположения
protocol LocationModuleInput {
	var moduleOutput: LocationModuleOutput? { get set }

	/// Повторяет запрос на получени данных по странам города и аэропортам
	func retryPrepareStorage()

	/// Обновлен город
	/// - Parameter code: код города
	func didUpdateCity(with code: String)

	/// Обновлена страна
	/// - Parameter code: код страны
	func didUpdateCountry(with code: String)

	/// Повторяет запрос на получение локации пользователя
	func retryGetLoaction()
}

/// Контроллер выбора местоположения
final class LocationViewController: UIViewController, LocationModuleInput {

	var moduleOutput: LocationModuleOutput?

	private lazy var locationView: LocationViewInput = LocationView()
	private let interactor: LocationInteractorInput
	private let viewModel: LocationViewModel

	/// Инициализатор
	/// - Parameters:
	///   - interactor: интерактор
	///   - router: роутер
	init(interactor: LocationInteractorInput) {
		self.interactor = interactor
		viewModel = .init()
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func loadView() {
		view = locationView
		locationView.output = self
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		locationView.showLoader()
		interactor.prepareStorage()
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.setNavigationBarHidden(true, animated: animated)
	}

	// MARK: - LocationModuleInput
	func didUpdateCity(with code: String) {
		guard let city = interactor.getCity(code: code) else {
			// TODO: Alert
			return
		}
		viewModel.city = city
		updateView()
	}

	func didUpdateCountry(with code: String) {
		guard let country = interactor.getCountry(code: code) else {
			// TODO: Alert
			return
		}
		viewModel.country = country
		viewModel.city = nil
		updateView()
		moduleOutput?.userSelectChangeCity(for: country.codeIATA)
	}

	func retryPrepareStorage() {
		locationView.showLoader()
		interactor.prepareStorage()
	}

	func retryGetLoaction() {
		locationView.showLoader()
		interactor.getLocation()
	}

	private func updateView() {
		if viewModel.country == nil {
			locationView.showCityErrorState()
			locationView.showCountryErrorState()
		} else if viewModel.city == nil {
			locationView.showCityErrorState()
		}

		guard let country = viewModel.country else {
			locationView.set(location: .init(country: "",
											 city: ""))
			locationView.showCityErrorState()
			locationView.showCountryErrorState()
			return
		}

		guard let city = viewModel.city else {
			locationView.set(location: .init(country: country.nameRu ?? country.name,
											 city: ""))
			locationView.showCityErrorState()
			locationView.showCountryErrorState()
			return
		}

		locationView.set(location: .init(country: country.nameRu ?? country.name,
										 city: city.nameRu ?? city.name))
	}
}

extension LocationViewController: LocationInteractorOutput {
	func didRecieveLocationError() {
		locationView.hideLoader()
		moduleOutput?.moduleDidRecieveLocationError()
	}

	func didPrepareStorage() {
		interactor.getLocation()
	}

	func didRecievePrepareStorageError() {
		locationView.hideLoader()
		moduleOutput?.moduleDidRecievePrepareStorageError()
	}

	func didRecieve(city: City) {
		viewModel.city = city
		updateView()
		locationView.hideLoader()
	}

	func didRecieve(country: Country) {
		viewModel.country = country
		updateView()
		locationView.hideLoader()
	}
}

extension LocationViewController: LocationViewOutput {
	func repeatButtonTapped() {
		// TODO: добавить кнопку повторить
	}

	func changeCityButtonTapped() {
		if let country = viewModel.country {
			moduleOutput?.userSelectChangeCity(for: country.codeIATA)
			return
		}
	}

	func acceptButtonTapped() {
		guard let city = viewModel.city, let country = viewModel.country else {
			updateView()
			return
		}
		moduleOutput?.userSelectLocation(with: city.codeIATA, countryCode: country.codeIATA)
	}

	func changeCountryButtonTapped() {
		moduleOutput?.userSelectChangeCountry()
	}
}
