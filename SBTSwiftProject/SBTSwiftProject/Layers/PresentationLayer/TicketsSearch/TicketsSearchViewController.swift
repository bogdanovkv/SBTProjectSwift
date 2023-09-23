//
//  TicketsSearchViewController.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 03.11.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import UIKit
import LocationDomain
import TicketsDomain

protocol TicketsSearchModuleOutput {

	func userSelectChangeDepartureLocation()

	func userSelectChangeDestinationLocation()

	func userSelectChangeDestinationCity(for code: String)

	func userSelectChangeDepartureCity(for code: String)

	func userSelectTicket(_ ticket: TicketPresentationModel)

	func somethingWentWrong()

	func noTicketsWereFound()
}

protocol TicketsSearchModuleInput {
	var moduleOutput: TicketsSearchModuleOutput? { get set }

	func changeDesinationCity(with code: String)

	func changeDepartureCity(with code: String)

	func changeDestinationCountry(with code: String)

	func changeDepartureCountry(with code: String)
}

/// Контроллер поиска билетов
final class TicketsSearchViewController: UIViewController, TicketsSearchModuleInput {
	var moduleOutput: TicketsSearchModuleOutput?

	private let viewModel: TicketsSearchViewModel
	private let interactor: TicketsSearchInteractorInput
	private let departureCityCode: String
	private let departureCountryCode: String
	private lazy var ticketsView: TicketsSearchViewInput &  UIView = {
		return TicketsSearchView()
	}()

	/// Инициализатор
	/// - Parameters:
	///   - departureCityCode: город отправления
	///   - departureCountryCode: страна отправления
	///   - interactor: интерактор
	///   - router: роутер
	init(departureCityCode: String,
		 departureCountryCode: String,
		 interactor: TicketsSearchInteractorInput) {
		viewModel = .init()
		viewModel.departureDate = Date()
		self.departureCityCode = departureCityCode
		self.departureCountryCode = departureCountryCode
		self.interactor = interactor
		super.init(nibName: nil, bundle: nil)
		modalPresentationStyle = .fullScreen
		title = "Поиск"
		tabBarItem = .init(tabBarSystemItem: .search, tag: 0)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func loadView() {
		view = ticketsView
		ticketsView.register(cellClass: TicketTableViewCell.self, for: TicketTableViewCell.reuseIdentifier)
		ticketsView.output = self
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		ticketsView.set(tableDataSource: self)
		ticketsView.set(tableDelegate: self)
		viewModel.departureCity = interactor.getCity(with: departureCityCode)
		viewModel.departureCountry = interactor.getCountry(with: departureCountryCode)
		updateView()
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.setNavigationBarHidden(true, animated: animated)
	}

	// MARK
	func changeDesinationCity(with code: String) {
		guard let city = self.interactor.getCity(with: code) else {
			moduleOutput?.somethingWentWrong()
			return
		}
		self.viewModel.desntinationCity = city
		self.updateView()
	}

	func changeDepartureCity(with code: String) {
		guard let city = self.interactor.getCity(with: code) else {
			moduleOutput?.somethingWentWrong()
			return
		}
		self.viewModel.departureCity = city
		self.updateView()	}

	func changeDestinationCountry(with code: String) {
		guard let country = self.interactor.getCountry(with: code) else {
			moduleOutput?.somethingWentWrong()
			return
		}
		self.viewModel.desntinationCountry = country
		self.updateView()
		self.userSelectChangeDestinationCity()
	}

	func changeDepartureCountry(with code: String) {
		guard let country = self.interactor.getCountry(with: code) else {
			moduleOutput?.somethingWentWrong()
			return
		}
		self.viewModel.departureCountry = country
		self.updateView()
		self.userSelectChangeDepartureCity()
	}

	private func updateView() {
		if let returnDate = viewModel.returnDate {
			ticketsView.set(returnDate: returnDate.format_DD_MM_YYYY())
		}
		if let departureDate = viewModel.departureDate {
			ticketsView.set(departureDate: departureDate.format_DD_MM_YYYY())
		}
		if let city = viewModel.departureCity {
			ticketsView.set(departureName:  city.nameRu ?? city.name)
		}
		if let city = viewModel.desntinationCity {
			ticketsView.set(destinationName: city.nameRu ?? city.name)
		}
		ticketsView.reload()
	}
}

extension TicketsSearchViewController: TicketsSearchViewOutput {

	func userStartSearch() {
		guard let fromCity = viewModel.departureCity, let toCity = viewModel.desntinationCity else {
			// TODO: - показать ошибку что не выбраны города
			return
		}
		ticketsView.showLoader()
		interactor.searchTickets(fromCity: fromCity,
								 fromDate: viewModel.departureDate,
								 toCity: toCity,
								 returnDate: viewModel.returnDate)
	}

	func userSelectChangeDepartureLocation() {
		moduleOutput?.userSelectChangeDepartureLocation()
	}

	private func userSelectChangeDepartureCity() {
		guard let country = viewModel.departureCountry else {
			return
		}
		moduleOutput?.userSelectChangeDepartureCity(for: country.codeIATA)
	}

	func userSelectChangeDestinationLocation() {
		moduleOutput?.userSelectChangeDestinationLocation()
	}

	private func userSelectChangeDestinationCity() {
		guard let country = viewModel.desntinationCountry else {
			return
		}
		moduleOutput?.userSelectChangeDestinationCity(for: country.codeIATA)
	}

	func userChangeDepartureDate(date: Date) {
		viewModel.departureDate = date
		updateView()
	}

	func userChangeReturnDate(date: Date) {
		viewModel.returnDate = date
		updateView()
	}
}

extension TicketsSearchViewController: TicketsSearchInteractorOutput {
	func didRecieveError() {
		moduleOutput?.somethingWentWrong()
	}

	func didRecieve(tickets: [Ticket]) {
		ticketsView.removeLoader()
		if tickets.isEmpty {
			moduleOutput?.noTicketsWereFound()
		}
		viewModel.tickets = tickets
		updateView()
	}

	func didRecieve(error: Error) {

	}
}

extension TicketsSearchViewController: UITableViewDelegate {

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		let model = viewModel.tickets[indexPath.row]
		moduleOutput?.userSelectTicket(.init(fromCityCode: model.fromCityCode,
											 toCityCode: model.toCityCode,
											 airlineCode: model.airlineCode,
											 departureDate: model.departureDate,
											 arrivalDate: model.arrivalDate,
											 cost: model.cost,
											 flightNumber: model.flightNumber,
											 expires: model.expires))
	}

}

extension TicketsSearchViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel.tickets.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: TicketTableViewCell.reuseIdentifier,
												 for: indexPath)
		guard let ticketCell = cell as? TicketTableViewCell else {
			return cell
		}
		let model = viewModel.tickets[indexPath.row]
		ticketCell.configure(with: model)
		return ticketCell
	}
}
