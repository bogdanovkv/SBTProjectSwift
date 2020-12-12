//
//  TicketTableViewCell.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 07.11.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import UIKit

/// Ячейка для отображения билета
final class TicketTableViewCell: UITableViewCell {

	/// Идентификатор для переиспользования
	static let reuseIdentifier = "TicketTableViewCellReuseIdentifier"

	private let departureDateLabel: UILabel
	private let departureLabel: UILabel
	private let destinationLabel: UILabel
	private let returnDateLabel: UILabel
	private let airlineCompanyLabel: UILabel
	private let priceLabel: UILabel

	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		departureDateLabel = .init()
		departureDateLabel.translatesAutoresizingMaskIntoConstraints = false
		departureDateLabel.textColor = .black

		departureLabel = .init()
		departureLabel.translatesAutoresizingMaskIntoConstraints = false
		departureLabel.textColor = .black

		destinationLabel = .init()
		destinationLabel.translatesAutoresizingMaskIntoConstraints = false
		destinationLabel.textColor = .black
		destinationLabel.textAlignment = .right

		returnDateLabel = .init()
		returnDateLabel.translatesAutoresizingMaskIntoConstraints = false
		returnDateLabel.textColor = .black
		returnDateLabel.textAlignment = .right

		airlineCompanyLabel = .init()
		airlineCompanyLabel.translatesAutoresizingMaskIntoConstraints = false
		airlineCompanyLabel.textColor = .black

		priceLabel = .init()
		priceLabel.translatesAutoresizingMaskIntoConstraints = false
		priceLabel.textColor = .black
		priceLabel.textAlignment = .right

		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupView()
		setupConstraints()
	}

	private func setupView() {
		contentView.addSubview(departureDateLabel)
		contentView.addSubview(departureLabel)
		contentView.addSubview(destinationLabel)
		contentView.addSubview(returnDateLabel)
		contentView.addSubview(airlineCompanyLabel)
		contentView.addSubview(priceLabel)
	}

	private func setupConstraints() {
		NSLayoutConstraint.activate([
			departureLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
			departureLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
			departureLabel.rightAnchor.constraint(equalTo: destinationLabel.leftAnchor, constant: -8),
			departureLabel.widthAnchor.constraint(equalTo: destinationLabel.widthAnchor),
			departureLabel.heightAnchor.constraint(equalToConstant: 22),

			destinationLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
			destinationLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
			destinationLabel.heightAnchor.constraint(equalTo: departureLabel.heightAnchor),

			departureDateLabel.topAnchor.constraint(equalTo: departureLabel.bottomAnchor, constant: 4),
			departureDateLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
			departureDateLabel.rightAnchor.constraint(equalTo: returnDateLabel.leftAnchor, constant: -8),
			departureDateLabel.widthAnchor.constraint(equalTo: returnDateLabel.widthAnchor),
			departureDateLabel.heightAnchor.constraint(equalTo: destinationLabel.heightAnchor),

			returnDateLabel.topAnchor.constraint(equalTo: destinationLabel.bottomAnchor, constant: 4),
			returnDateLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
			returnDateLabel.heightAnchor.constraint(equalTo: departureDateLabel.heightAnchor),

			airlineCompanyLabel.topAnchor.constraint(equalTo: departureDateLabel.bottomAnchor, constant: 4),
			airlineCompanyLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
			airlineCompanyLabel.rightAnchor.constraint(equalTo: priceLabel.leftAnchor, constant: -8),
			airlineCompanyLabel.widthAnchor.constraint(equalTo: priceLabel.widthAnchor),
			airlineCompanyLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),

			priceLabel.topAnchor.constraint(equalTo: returnDateLabel.bottomAnchor, constant: 4),
			priceLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
			priceLabel.heightAnchor.constraint(equalTo: airlineCompanyLabel.heightAnchor),
			priceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4)
		])
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	/// Утанавливает модель в ячейку
	/// - Parameter model: модель
	func configure(with model: Ticket) {
		departureLabel.text = model.fromCity.nameRu ?? model.fromCity.name
		destinationLabel.text = model.toCity.nameRu ?? model.toCity.name
		departureDateLabel.text = model.departureDate.format_DD_MM_YYYY()
		returnDateLabel.text = model.arrivalDate.format_DD_MM_YYYY()
		priceLabel.text = "\(model.cost) р."
		airlineCompanyLabel.text = "Код линии - \(model.airlineCode)"
	}
}
