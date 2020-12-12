//
//  TicketView.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 21.11.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import UIKit

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

		super.init(frame: .zero)
		setupView()
		setupConstraints()
	}

	required init?(coder: NSCoder) {
		fatalError()
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

		])
	}
}

