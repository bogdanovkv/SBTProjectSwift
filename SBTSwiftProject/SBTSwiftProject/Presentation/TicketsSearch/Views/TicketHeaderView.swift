//
//  TicketHeaderView.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 04.11.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import UIKit

/// Шапка экрана поиска билетов для ввода запроса
final class TicketHeaderView: UIView {

	let departureCityLabel: UILabel
	let departureDateLabel: UILabel
	let destinationCityLabel: UILabel
	let returnDateLabel: UILabel
	let searchButton: UIButton

	init() {
		departureCityLabel = .init()
		departureCityLabel.translatesAutoresizingMaskIntoConstraints = false
		departureCityLabel.textColor = .black

		departureDateLabel = .init()
		departureDateLabel.translatesAutoresizingMaskIntoConstraints = false
		departureDateLabel.textColor = .black

		destinationCityLabel = .init()
		destinationCityLabel.translatesAutoresizingMaskIntoConstraints = false
		destinationCityLabel.textColor = .black

		returnDateLabel = .init()
		returnDateLabel.translatesAutoresizingMaskIntoConstraints = false
		returnDateLabel.textColor = .black

		searchButton = .init()
		searchButton.translatesAutoresizingMaskIntoConstraints = false
		searchButton.setTitle("искать", for: .normal)
		searchButton.setTitleColor(.black, for: .normal)
		searchButton.setTitleColor(.gray, for: .highlighted)
		searchButton.backgroundColor = .gray
		searchButton.layer.cornerRadius = 5
		searchButton.layer.masksToBounds = false
		super.init(frame: .zero)
		setupViews()
		setupContraints()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupViews() {
		addSubview(departureCityLabel)
		addSubview(departureDateLabel)
		addSubview(destinationCityLabel)
		addSubview(returnDateLabel)
		addSubview(searchButton)
	}

	private func setupContraints() {
		NSLayoutConstraint.activate([
			departureCityLabel.topAnchor.constraint(equalTo: topAnchor, constant: 4),
			departureCityLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
			departureCityLabel.heightAnchor.constraint(equalToConstant: 30),

			departureDateLabel.topAnchor.constraint(equalTo: departureCityLabel.bottomAnchor, constant: 4),
			departureDateLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
			departureDateLabel.heightAnchor.constraint(equalToConstant: 30),

			destinationCityLabel.topAnchor.constraint(equalTo: topAnchor, constant: 4),
			destinationCityLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -8),
			destinationCityLabel.widthAnchor.constraint(equalTo: departureCityLabel.widthAnchor),
			destinationCityLabel.leftAnchor.constraint(equalTo: departureCityLabel.rightAnchor, constant: 4),
			destinationCityLabel.heightAnchor.constraint(equalToConstant: 30),

			returnDateLabel.topAnchor.constraint(equalTo: destinationCityLabel.bottomAnchor, constant: 4),
			returnDateLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -8),
			returnDateLabel.widthAnchor.constraint(equalTo: departureDateLabel.widthAnchor),
			returnDateLabel.leftAnchor.constraint(equalTo: departureDateLabel.rightAnchor, constant: 4),
			returnDateLabel.heightAnchor.constraint(equalToConstant: 30),

			searchButton.topAnchor.constraint(equalTo: departureDateLabel.bottomAnchor, constant: 4),
			searchButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -8),
			searchButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
			searchButton.heightAnchor.constraint(equalToConstant: 30),
			searchButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4)
		])
	}
}
