//
//  ViewController.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 14.07.2018.
//  Copyright © 2018 Константин Богданов. All rights reserved.
//

import UIKit

protocol LocationViewControllerInput: LocationViewController {
	/// Повторяет запрос на получени данных по странам города и аэропортам
	func retryPrepareStorage()

	/// Повторяет запрос на получение локации пользователя
	func retryGetLoaction()
}

final class LocationViewController: UIViewController, LocationViewControllerInput {

	private lazy var locationView: LocationViewInput = LocationView()
	private let interactor: LocationInteractorInput
	private let viewModel: LocationViewModel
	private let router: LocationRouterProtocol

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
		interactor.prepareStorage()
	}

	func retryPrepareStorage() {
		interactor.prepareStorage()
	}

	func retryGetLoaction() {
		interactor.getLocation()
	}

	private func updateView() {
		locationView.set(location: .init(country: viewModel.country?.nameRu ?? "",
										 city: viewModel.city?.nameRu ?? ""))
	}
}

extension LocationViewController: LocationInteractorOutput {
	func didRecieveLocationError() {
		router.showLocationErrorAlert(on: self)
	}

	func didPrepareStorage() {
		interactor.getLocation()
	}

	func didRecievePrepareStorageError() {
		router.showStorageErrorAlert(on: self)
	}

	func didRecieve(city: CityModel) {
		viewModel.city = city
		updateView()
	}

	func didRecieve(country: CountryModel) {
		viewModel.country = country
		updateView()
	}

	func didUpdateLocation(_ location: LocationModel) {

	}
}

extension LocationViewController: LocationViewOutput {
	func repeatButtonTapped() {
	}

	func changeCityButtonTapped() {
		if let country = viewModel.country {
			router.showSelectCityController(with: country, on: self)
			return
		}
	}

	func acceptButtonTapped() {
		let repo = TicketsRepository()
		repo.loadTickets(fromCity: viewModel.city!, fromDate: Date(), toCity: CityModel(codeIATA: "LED", countryCode: "RU", name: "", nameRu: nil), returnDate: nil) { result in
			print(repo)
		}
	}

	func changeCountryButtonTapped() {
		router.showSelectCountryController(on: self)
	}
}

extension LocationViewController: SelectCountryViewControllerOutput {
	func userSelect(country: CountryModel) {
		viewModel.country = country
		viewModel.city = nil
		updateView()
	}
}

extension LocationViewController: SelectCityViewControllerOutput {
	func userSelect(city: CityModel) {
		viewModel.city = city
		updateView()
	}
}
