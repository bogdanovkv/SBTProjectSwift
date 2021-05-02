//
//  TicketViewController.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 21.11.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import UIKit

/// Обработчик событий от модуля билета
protocol TicketModuleOutput {

	/// Не удалось найти город отправления для билета
	func cannotFindFromCityForCodeInTicker()

	/// Не удалось найти страну оправления для билета
	func cannotFindFromCountryForCodeInTicker()

	/// Не удалось найти город назначения для билета
	func cannotFindToCityForCodeInTicker()

	/// Не удалось найти страну назначения для билета
	func cannotFindToCountryForCodeInTicker()
}

protocol TicketModuleInput {
	var moduleOutput: TicketModuleOutput? { get set }
}

/// Контролллер для отображения билета
final class TicketViewController: UIViewController, TicketModuleInput {
	var moduleOutput: TicketModuleOutput?
	private lazy var moduleView: UIView & TicketViewInput = TicketView()
	private let viewModel: TicketViewModel
	private let interactor: TicketInteractorInput

	/// Инициализатор
	/// - Parameters:
	///   - viewModel: модель для view
	///   - interactor: интерактор
	init(viewModel: TicketViewModel, interactor: TicketInteractorInput) {
		self.viewModel = viewModel
		self.interactor = interactor
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func loadView() {
		self.view = moduleView
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.setNavigationBarHidden(true, animated: animated)
	}

	private func setupView() {
		guard let fromCity = interactor.getCity(by: viewModel.ticket.fromCityCode) else {
			moduleOutput?.cannotFindFromCityForCodeInTicker()
			return
		}

		guard let toCity = interactor.getCity(by: viewModel.ticket.toCityCode) else {
			moduleOutput?.cannotFindToCityForCodeInTicker()
			return
		}

		guard let fromCountry = interactor.getCountry(by: fromCity.countryCode) else {
			moduleOutput?.cannotFindToCountryForCodeInTicker()
			return
		}

		guard let toCountry = interactor.getCountry(by: toCity.countryCode) else {
			moduleOutput?.cannotFindToCountryForCodeInTicker()
			return
		}

		moduleView.configure(with: viewModel,
							 destinationCity: toCity,
							 destinationCountry: toCountry,
							 departureCity: fromCity,
							 departureCountry: fromCountry)

	}
}
