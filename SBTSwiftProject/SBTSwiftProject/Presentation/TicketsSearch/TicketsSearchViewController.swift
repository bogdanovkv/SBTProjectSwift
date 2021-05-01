//
//  TicketsSearchViewController.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 03.11.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import UIKit
import LocationDomainAbstraction
import TicketsDomainAbstraction

/// Контроллер поиска билетов
final class TicketsSearchViewController: UIViewController {

	private let viewModel: TicketsSearchViewModel
	private let router: TicketsSearchRouterProtocol
	private let interactor: TicketsSearchInteractorInput
	private lazy var ticketsView: TicketsSearchViewInput &  UIView = {
		return TicketsSearchView()
	}()

	/// Инициализатор
	/// - Parameters:
	///   - departureCity: город отправления
	///   - departureCountry: страна отправления
	///   - interactor: интерактор
	///   - router: роутер
	init(departureCity: City,
		 departureCountry: Country,
		 interactor: TicketsSearchInteractorInput,
		 router: TicketsSearchRouterProtocol) {
		viewModel = .init()
		viewModel.departureCity = departureCity
		viewModel.departureCountry = departureCountry
		viewModel.departureDate = Date()
		self.router = router
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
		updateView()
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
		router.showChangeCountryViewController(on: self) { [weak self] countryCode in
			guard let self = self else { return }
			guard let country = self.interactor.getCountry(with: countryCode) else {
				self.router.showSomethingWentWrongAlert(on: self)
				return
			}
			self.viewModel.departureCountry = country
			self.updateView()
			self.userSelectChangeDepartureCity()
		}
	}

	private func userSelectChangeDepartureCity() {
		guard let country = viewModel.departureCountry else {
			return
		}
		router.showChangeCityViewController(on: self,
											country: country,
											completion: { [weak self] cityCode in
												guard let self = self else { return }
												guard let city = self.interactor.getCity(with: cityCode) else {
													self.router.showSomethingWentWrongAlert(on: self)
													return
												}
												self.viewModel.departureCity = city
												self.updateView()
											})
	}

	func userSelectChangeDestinationLocation() {
		router.showChangeCountryViewController(on: self) { [weak self] countryCode in
			guard let self = self else { return }
			guard let country = self.interactor.getCountry(with: countryCode) else {
				self.router.showSomethingWentWrongAlert(on: self)
				return
			}
			self.viewModel.desntinationCountry = country
			self.updateView()
			self.userSelectChangeDestinationCity()
		}
	}

	private func userSelectChangeDestinationCity() {
		guard let country = viewModel.desntinationCountry else {
			return
		}
		router.showChangeCityViewController(on: self,
											country: country,
											completion: { [weak self] cityCode in
												guard let self = self else { return }
												guard let city = self.interactor.getCity(with: cityCode) else {
													self.router.showSomethingWentWrongAlert(on: self)
													return
												}
												self.viewModel.desntinationCity = city
												self.updateView()
											})
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
		router.showSomethingWentWrongAlert(on: self)
	}

	func didRecieve(country: Country) {
		updateView()
		userSelectChangeDestinationCity()
	}

	func didRecieve(city: City) {
		// TODO: Implement
//		viewModel.city = city
		updateView()
	}

	func didRecieve(tickets: [Ticket]) {
		ticketsView.removeLoader()
		if tickets.isEmpty {
			router.showNoTicketsFoundAlert(on: self)
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
		router.showTicketInformationController(on: self,
											   ticket: model)

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
