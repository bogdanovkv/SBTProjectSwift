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

	/// Лебйл для отображения города отправления
	let departureCityLabel: UILabel

	/// Лебйл для отображения даты отвравления
	let departureDateLabel: UILabel

	/// Лейбл для отобраения города назначения
	let destinationCityLabel: UILabel

	/// Лейбл для отображения даты возврата назад
	let returnDateLabel: UILabel

	/// Кнопка поиска
	let searchButton: UIButton

	/// Инициализатор
	init() {
		departureCityLabel = .init()
		departureCityLabel.text = "Откуда"
		departureCityLabel.translatesAutoresizingMaskIntoConstraints = false
		departureCityLabel.textColor = .black
		departureCityLabel.backgroundColor = .init(red: 231/255, green: 231/255, blue: 233/255, alpha: 1)

		departureDateLabel = .init()
		departureDateLabel.translatesAutoresizingMaskIntoConstraints = false
		departureDateLabel.textColor = .black
		departureDateLabel.text = "Дата вылета"
		departureDateLabel.backgroundColor = .init(red: 231/255, green: 231/255, blue: 233/255, alpha: 1)

		destinationCityLabel = .init()
		destinationCityLabel.translatesAutoresizingMaskIntoConstraints = false
		destinationCityLabel.textColor = .black
		destinationCityLabel.text = "Куда"
		destinationCityLabel.textAlignment = .right
		destinationCityLabel.backgroundColor = .init(red: 231/255, green: 231/255, blue: 233/255, alpha: 1)

		returnDateLabel = .init()
		returnDateLabel.translatesAutoresizingMaskIntoConstraints = false
		returnDateLabel.textColor = .black
		returnDateLabel.text = "Дата вылета обратно"
		returnDateLabel.textAlignment = .right
		returnDateLabel.backgroundColor = .init(red: 231/255, green: 231/255, blue: 233/255, alpha: 1)


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
