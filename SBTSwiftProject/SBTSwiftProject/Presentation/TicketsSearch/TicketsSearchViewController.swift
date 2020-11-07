//
//  TicketsSearchViewController.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 03.11.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import UIKit

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
	init(departureCity: CityModel,
		 departureCountry: CountryModel,
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
		ticketsView.register(cellClass: UITableViewCell.self, for: "Cell")
		ticketsView.output = self
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		ticketsView.set(tableDataSource: self)
		ticketsView.set(tableDelegate: self)
		updateView()
	}

	private func updateView() {
		ticketsView.set(returnDate: viewModel.returnDate?.format_DD_MM_YYYY() ?? "")
		ticketsView.set(departureDate: viewModel.departureDate?.format_DD_MM_YYYY() ?? "")
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
			return
		}
		interactor.searchTickets(fromCity: fromCity,
								 fromDate: viewModel.departureDate,
								 toCity: toCity,
								 returnDate: viewModel.returnDate)
	}

	func userSelectChangeDepartureLocation() {
		router.showChangeCountryViewController(on: self) { [weak self] country in
			self?.viewModel.departureCountry = country
			self?.updateView()
			self?.userSelectChangeDepartureCity()
		}
	}

	private func userSelectChangeDepartureCity() {
		guard let country = viewModel.departureCountry else {
			return
		}
		router.showChangeCityViewController(on: self,
											country: country,
											completion: { [weak self] city in
												self?.viewModel.departureCity = city
												self?.updateView()
											})
	}

	func userSelectChangeDestinationLocation() {
		router.showChangeCountryViewController(on: self) { [weak self] country in
			self?.viewModel.desntinationCountry = country
			self?.updateView()
			self?.userSelectChangeDestinationCity()
		}
	}

	private func userSelectChangeDestinationCity() {
		guard let country = viewModel.desntinationCountry else {
			return
		}
		router.showChangeCityViewController(on: self,
											country: country,
											completion: { [weak self] city in
												self?.viewModel.desntinationCity = city
												self?.updateView()
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
	func didRecieve(tickets: [Ticket]) {
		self.viewModel.tickets = tickets
		updateView()
	}

	func didRecieve(error: Error) {

	}
}

extension TicketsSearchViewController: UITableViewDelegate {

}

extension TicketsSearchViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel.tickets.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

		let model = viewModel.tickets[indexPath.row]
		cell.textLabel?.text = "\(model.airlineCode) \(model.cost)"
		return cell
	}


}
