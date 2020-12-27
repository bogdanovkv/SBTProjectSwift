//
//  TicketView.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 21.11.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import UIKit

/// Обработчик событий от вью отображения билетов
protocol TicketViewOutput: AnyObject {

	/// Пользователь выбрал выход с экрана
	func userSelectBack()

	/// Пользователь выбрал сохранить билет
	func userSelectSaveTicket()

}

/// Вью для отображения информации о билете
final class TicketView: UIView {

	private let departureCountryLabel: UILabel
	private let departureCityLabel: UILabel
	private let destinationCityLabel: UILabel
	private let destinationCountryLabel: UILabel
	private let departureDateLabel: UILabel
	private let destinationDateLabel: UILabel
	private let airlineCodeLabel: UILabel
	private let costLabel: UILabel
	private let expiredDateLable: UILabel
	private let flightNumberLabel: UILabel
	private let saveButton: UIButton

	/// Инициализатор
	init() {
		departureCountryLabel = .init()
		departureCountryLabel.translatesAutoresizingMaskIntoConstraints = false

		departureCityLabel = .init()
		departureCityLabel.translatesAutoresizingMaskIntoConstraints = false

		destinationCityLabel = .init()
		destinationCityLabel.translatesAutoresizingMaskIntoConstraints = false

		destinationCountryLabel = .init()
		destinationCountryLabel.translatesAutoresizingMaskIntoConstraints = false

		departureDateLabel = .init()
		departureDateLabel.translatesAutoresizingMaskIntoConstraints = false

		destinationDateLabel = .init()
		destinationDateLabel.translatesAutoresizingMaskIntoConstraints = false

		airlineCodeLabel = .init()
		airlineCodeLabel.translatesAutoresizingMaskIntoConstraints = false

		costLabel = .init()
		costLabel.translatesAutoresizingMaskIntoConstraints = false

		expiredDateLable = .init()
		expiredDateLable.translatesAutoresizingMaskIntoConstraints = false

		flightNumberLabel = .init()
		flightNumberLabel.translatesAutoresizingMaskIntoConstraints = false

		saveButton = .init()
		saveButton.translatesAutoresizingMaskIntoConstraints = false
		saveButton.backgroundColor = .gray
		saveButton.layer.cornerRadius = 8
		saveButton.setTitle("Сохранить", for: .normal)
		saveButton.setTitleColor(.black, for: .normal)
		saveButton.setTitleColor(.white, for: .highlighted)

		super.init(frame: .zero)
		backgroundColor = .blue
		setupView()
		setupConstraints()
	}

	required init?(coder: NSCoder) {
		fatalError()
	}

	/// Конфигурирует вью с моделью билета
	/// - Parameter ticket: билет
	func configure(with ticket: TicketViewModel) {
		let destinationCityName = (ticket.destinationCity.nameRu ?? ticket.destinationCity.name)
		let destinationCountryName = (ticket.destinationCountry.nameRu ?? ticket.destinationCountry.name)
		destinationCityLabel.text = "Страна назначения: " + destinationCityName
		destinationCountryLabel.text = "Город назначения: " + destinationCountryName
		destinationDateLabel.text = ticket.ticket.arrivalDate.format_DD_MM_YYYY()

		let departureCityName = (ticket.destinationCity.nameRu ?? ticket.destinationCity.name)
		let dapartureCountryName = (ticket.destinationCountry.nameRu ?? ticket.destinationCountry.name)
		departureCountryLabel.text = "Страна отправления: " + dapartureCountryName
		departureCityLabel.text = "Город отправления: " + departureCityName
		departureDateLabel.text = ticket.ticket.departureDate.format_DD_MM_YYYY()

		airlineCodeLabel.text = "Код авиалинии " + ticket.ticket.airlineCode
		flightNumberLabel.text = "Рейс №\(ticket.ticket.flightNumber)"

		expiredDateLable.text = "Истекает " + ticket.ticket.expires.format_DD_MM_YYYY()
		costLabel.text = "Цена: \(ticket.ticket.cost)р."
	}

	private func setupView() {
		addSubview(departureCountryLabel)
		addSubview(departureCityLabel)
		addSubview(destinationCountryLabel)
		addSubview(destinationCityLabel)
		addSubview(departureDateLabel)
		addSubview(destinationDateLabel)
		addSubview(airlineCodeLabel)
		addSubview(costLabel)
		addSubview(expiredDateLable)
		addSubview(flightNumberLabel)
		addSubview(saveButton)
	}

	private func setupConstraints() {
		let labelHeiht: CGFloat = 16.0
		NSLayoutConstraint.activate([
			departureCountryLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
			departureCountryLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
			departureCountryLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
			departureCountryLabel.heightAnchor.constraint(equalToConstant: labelHeiht),

			departureCityLabel.topAnchor.constraint(equalTo: departureCountryLabel.bottomAnchor, constant: 8),
			departureCityLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
			departureCityLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
			departureCityLabel.heightAnchor.constraint(equalToConstant: labelHeiht),

			departureDateLabel.topAnchor.constraint(equalTo: departureCityLabel.bottomAnchor, constant: 8),
			departureDateLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
			departureDateLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
			departureDateLabel.heightAnchor.constraint(equalToConstant: labelHeiht),

			destinationCountryLabel.topAnchor.constraint(equalTo: departureDateLabel.bottomAnchor, constant: 8),
			destinationCountryLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
			destinationCountryLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
			destinationCountryLabel.heightAnchor.constraint(equalToConstant: labelHeiht),

			destinationCityLabel.topAnchor.constraint(equalTo: destinationCountryLabel.bottomAnchor, constant: 8),
			destinationCityLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
			destinationCityLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
			destinationCityLabel.heightAnchor.constraint(equalToConstant: labelHeiht),

			destinationDateLabel.topAnchor.constraint(equalTo: destinationCityLabel.bottomAnchor, constant: 8),
			destinationDateLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
			destinationDateLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
			destinationDateLabel.heightAnchor.constraint(equalToConstant: labelHeiht),

			airlineCodeLabel.topAnchor.constraint(equalTo: destinationDateLabel.bottomAnchor, constant: 8),
			airlineCodeLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
			airlineCodeLabel.heightAnchor.constraint(equalToConstant: labelHeiht),
			airlineCodeLabel.widthAnchor.constraint(equalTo: costLabel.widthAnchor),
			airlineCodeLabel.rightAnchor.constraint(equalTo: costLabel.leftAnchor, constant: -4),

			costLabel.topAnchor.constraint(equalTo: destinationDateLabel.bottomAnchor, constant: 8),
			costLabel.heightAnchor.constraint(equalToConstant: labelHeiht),
			costLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),

			expiredDateLable.topAnchor.constraint(equalTo: airlineCodeLabel.bottomAnchor, constant: 8),
			expiredDateLable.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
			expiredDateLable.heightAnchor.constraint(equalToConstant: labelHeiht),
			expiredDateLable.widthAnchor.constraint(equalTo: flightNumberLabel.widthAnchor),
			expiredDateLable.rightAnchor.constraint(equalTo: flightNumberLabel.leftAnchor, constant: -4),

			flightNumberLabel.topAnchor.constraint(equalTo: costLabel.bottomAnchor, constant: 8),
			flightNumberLabel.heightAnchor.constraint(equalToConstant: labelHeiht),
			flightNumberLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),

			saveButton.topAnchor.constraint(equalTo: expiredDateLable.bottomAnchor, constant: 8),
			saveButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
			saveButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
			saveButton.heightAnchor.constraint(equalToConstant: labelHeiht * 2),
		])
	}
}

