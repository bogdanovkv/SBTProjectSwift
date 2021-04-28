//
//  ViewController.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 14.07.2018.
//  Copyright © 2018 Константин Богданов. All rights reserved.
//

import UIKit
import LocationDomainAbstraction

/// Протокол контроллера выбора местоположения
protocol LocationViewControllerInput: LocationViewController {
	/// Повторяет запрос на получени данных по странам города и аэропортам
	func retryPrepareStorage()

	/// Повторяет запрос на получение локации пользователя
	func retryGetLoaction()
}

/// Контроллер выбора местоположения
final class LocationViewController: UIViewController, LocationViewControllerInput {

	private lazy var locationView: LocationViewInput = LocationView()
	private let interactor: LocationInteractorInput
	private let viewModel: LocationViewModel
	private let router: LocationRouterProtocol

	/// Инициализатор
	/// - Parameters:
	///   - interactor: интерактор
	///   - router: роутер
	init(interactor: LocationInteractorInput,
		 router: LocationRouterProtocol) {
		self.interactor = interactor
		self.router = router
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
		router.showLocationErrorAlert(on: self)
	}

	func didPrepareStorage() {
		interactor.getLocation()
	}

	func didRecievePrepareStorageError() {
		locationView.hideLoader()
		router.showStorageErrorAlert(on: self)
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
			router.showSelectCityController(with: country, on: self)
			return
		}
	}

	func acceptButtonTapped() {
		guard let city = viewModel.city, let country = viewModel.country else {
			updateView()
			return
		}
		router.openTabBarViewController(with: city, country: country, on: self)
	}

	func changeCountryButtonTapped() {
		router.showSelectCountryController(on: self)
	}
}

extension LocationViewController: SelectCountryViewControllerOutput {
	func userSelect(country: Country) {
		viewModel.country = country
		viewModel.city = nil
		updateView()
	}
}

extension LocationViewController: SelectCityViewControllerOutput {
	func userSelect(city: City) {
		viewModel.city = city
		updateView()
	}
}
