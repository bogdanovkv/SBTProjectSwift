//
//  TicketsSearchView.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 04.11.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import UIKit

/// Output вью поиска билелетов
protocol TicketsSearchViewOutput: AnyObject {

	/// Пользователь начал поиск
	func userStartSearch()

	/// Пользователь выбрал изменить город вылета
	func userSelectChangeDepartureLocation()

	/// Пользователь выбрал изменить город назначения
	func userSelectChangeDestinationLocation()

	/// Пользователь изменил дату вылета
	/// - Parameter date: дата вылета
	func userChangeDepartureDate(date: Date)

	/// Польщователь изменил дату возврата
	/// - Parameter date: дата возврата
	func userChangeReturnDate(date: Date)
}

protocol TicketsSearchViewInput: AnyObject {

	var output: TicketsSearchViewOutput? { get set }

	/// Устанавливает имя города отправления
	/// - Parameter departureName: город
	func set(departureName: String)

	/// Устанавливает имя города куда планируется полет
	/// - Parameter destinationName: город
	func set(destinationName: String)

	/// Устанавливает дату  вылета
	/// - Parameter departureDate: строка с датой
	func set(departureDate: String)

	/// Устанавливает дату вылета обратно
	/// - Parameter returnDate: строка с датой
	func set(returnDate: String)

	/// Устанавливает делеагата таблицы
	/// - Parameter tableDelegate: табличный делегат
	func set(tableDelegate: UITableViewDelegate)

	/// Устанавливает табличный дата сорс
	/// - Parameter tableDataSource: дата сорс
	func set(tableDataSource: UITableViewDataSource)

	/// Регистрирует класс ячейки
	/// - Parameters:
	///   - cellClass: класс
	///   - identifier: идентификатор
	func register(cellClass: AnyClass, for identifier: String)

	/// Перезагружает табличку
	func reload()
}

final class TicketsSearchView: UIView, TicketsSearchViewInput {

	weak var output: TicketsSearchViewOutput?

	private let headerView: TicketHeaderView
	private let tableView: UITableView
	private var picker: TicketsSearchDatePicker?

	init() {
		headerView = .init()
		headerView.translatesAutoresizingMaskIntoConstraints = false
		tableView = .init(frame: .zero, style: .plain)
		tableView.translatesAutoresizingMaskIntoConstraints = false
		super.init(frame: .zero)
		backgroundColor = .white
		setupActions()
		setupView()
		setupCostraints()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func setupActions() {
		let departureCityRecognaizer = UITapGestureRecognizer(target: self,
															  action: #selector(departureCityLabelTapped))
		headerView.departureCityLabel.addGestureRecognizer(departureCityRecognaizer)

		let destinationCityRecognaizer = UITapGestureRecognizer(target: self,
																action: #selector(destinationCityLabelTapped))
		headerView.destinationCityLabel.addGestureRecognizer(destinationCityRecognaizer)

		let departureDateRecognaizer = UITapGestureRecognizer(target: self,
															  action: #selector(departureDateLabelTapped))

		headerView.departureDateLabel.addGestureRecognizer(departureDateRecognaizer)
		let returnDateRecognaizer = UITapGestureRecognizer(target: self,
															  action: #selector(returnDateLabelTapped))
		headerView.returnDateLabel.addGestureRecognizer(returnDateRecognaizer)

		headerView.searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
	}

	private func setupView() {
		headerView.departureCityLabel.isUserInteractionEnabled = true
		headerView.departureDateLabel.isUserInteractionEnabled = true
		headerView.returnDateLabel.isUserInteractionEnabled = true
		headerView.destinationCityLabel.isUserInteractionEnabled = true
		addSubview(headerView)
		addSubview(tableView)
	}

	private func setupCostraints() {
		NSLayoutConstraint.activate([
			headerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
			headerView.leftAnchor.constraint(equalTo: leftAnchor),
			headerView.rightAnchor.constraint(equalTo: rightAnchor),

			tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
			tableView.leftAnchor.constraint(equalTo: leftAnchor),
			tableView.rightAnchor.constraint(equalTo: rightAnchor),
			tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
		])
	}

	func set(departureName: String) {
		headerView.departureCityLabel.text = departureName
	}

	func set(destinationName: String) {
		headerView.destinationCityLabel.text = destinationName
	}

	func set(departureDate: String) {
		headerView.departureDateLabel.text = departureDate
	}

	func set(returnDate: String) {
		headerView.returnDateLabel.text = returnDate
	}

	func set(tableDelegate: UITableViewDelegate) {
		tableView.delegate = tableDelegate
	}

	func set(tableDataSource: UITableViewDataSource) {
		tableView.dataSource = tableDataSource
	}

	func register(cellClass: AnyClass, for identifier: String) {
		tableView.register(cellClass, forCellReuseIdentifier: identifier)
	}

	func reload() {
		tableView.reloadData()
	}

	// MARK: - Private

	@objc private func departureCityLabelTapped() {
		output?.userSelectChangeDepartureLocation()
	}

	@objc private func destinationCityLabelTapped() {
		output?.userSelectChangeDestinationLocation()
	}

	@objc private func departureDateLabelTapped() {
		showPicker { [weak self] date in
			self?.picker?.removeFromSuperview()
			self?.picker = nil
			self?.output?.userChangeDepartureDate(date: date)
		}
	}

	@objc private func returnDateLabelTapped() {
		showPicker { [weak self] date in
			self?.picker?.removeFromSuperview()
			self?.picker = nil
			self?.output?.userChangeReturnDate(date: date)
		}
	}

	@objc private func searchButtonTapped() {
		output?.userStartSearch()
	}

	private func showPicker(with action: @escaping (Date) -> Void) {
		guard picker == nil else {
			return
		}
		let picker = TicketsSearchDatePicker(action: action)
		picker.translatesAutoresizingMaskIntoConstraints = false
		addSubview(picker)
		NSLayoutConstraint.activate([
			picker.bottomAnchor.constraint(equalTo: tableView.bottomAnchor),
			picker.leftAnchor.constraint(equalTo: tableView.leftAnchor),
			picker.rightAnchor.constraint(equalTo: tableView.rightAnchor),
		])
		self.picker = picker
	}
}
