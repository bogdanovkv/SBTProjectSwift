//
//  LocationView.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 24.10.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import UIKit

protocol LocationViewOutput: AnyObject {
	func repeatButtonTapped()
	func changeCityButtonTapped()
	func acceptButtonTapped()
	func changeCountryButtonTapped()
}

protocol LocationViewInput: UIView {
	var output: LocationViewOutput? { get set }
	func set(location: LocationModel)
}

final class LocationView: UIView {

	weak var output: LocationViewOutput?

	private let titleLabel: UILabel
	private let countryLabel: UILabel
	private let cityLabel: UILabel
	private let changeCountryButton: UIButton
	private let changeCityButton: UIButton
	private let acceptButton: UIButton

	init() {
		titleLabel = .init(frame: .zero)
		titleLabel.text = "Выберите ваше местоположение"
		titleLabel.translatesAutoresizingMaskIntoConstraints = false
		titleLabel.textColor = .black

		countryLabel = .init(frame: .zero)
		countryLabel.translatesAutoresizingMaskIntoConstraints = false
		countryLabel.textColor = .black

		cityLabel = .init(frame: .zero)
		cityLabel.translatesAutoresizingMaskIntoConstraints = false

		changeCountryButton = .init()
		changeCountryButton.translatesAutoresizingMaskIntoConstraints = false
		changeCountryButton.setTitle("Изменить страну", for: .normal)
		changeCountryButton.setTitleColor(.black, for: .normal)
		changeCountryButton.layer.borderColor = UIColor.black.cgColor
		changeCountryButton.layer.cornerRadius = 4
		changeCountryButton.layer.borderWidth = 2

		changeCityButton = .init()
		changeCityButton.translatesAutoresizingMaskIntoConstraints = false
		changeCityButton.setTitle("Изменить город", for: .normal)
		changeCityButton.setTitleColor(.black, for: .normal)
		changeCityButton.setTitleColor(.gray, for: .highlighted)
		changeCityButton.layer.borderColor = UIColor.black.cgColor
		changeCityButton.layer.cornerRadius = 4
		changeCityButton.layer.borderWidth = 2

		acceptButton = .init()
		acceptButton.translatesAutoresizingMaskIntoConstraints = false
		acceptButton.setTitle("Выбрать", for: .normal)
		acceptButton.setTitleColor(.black, for: .normal)
		acceptButton.setTitleColor(.gray, for: .highlighted)
		acceptButton.layer.borderColor = UIColor.black.cgColor
		acceptButton.layer.cornerRadius = 4
		acceptButton.layer.borderWidth = 2

		super.init(frame: .zero)
		setupActions()
		setupSubviews()
		setupContraints()
		backgroundColor = .white
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func setupActions() {
		changeCityButton.addTarget(self, action: #selector(changeCityButtonTapped), for: .touchUpInside)
		changeCountryButton.addTarget(self, action: #selector(changeCountryButtonTapped), for: .touchUpInside)
		acceptButton.addTarget(self, action: #selector(acceptButtonTapped), for: .touchUpInside)
	}

	private func setupSubviews() {
		addSubview(titleLabel)
		addSubview(countryLabel)
		addSubview(cityLabel)
		addSubview(changeCountryButton)
		addSubview(changeCityButton)
		addSubview(acceptButton)
	}

	private func setupContraints() {
		NSLayoutConstraint.activate([
			titleLabel.heightAnchor.constraint(equalToConstant: 25),
			titleLabel.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor),
			titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
			titleLabel.bottomAnchor.constraint(equalTo: countryLabel.topAnchor, constant: -4),

			countryLabel.bottomAnchor.constraint(equalTo: changeCountryButton.topAnchor, constant: -4),
			countryLabel.heightAnchor.constraint(equalToConstant: 25),
			countryLabel.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor),
			countryLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

			changeCountryButton.bottomAnchor.constraint(equalTo: centerYAnchor, constant: -4),
			changeCountryButton.heightAnchor.constraint(equalToConstant: 40),
			changeCountryButton.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor),
			changeCountryButton.centerXAnchor.constraint(equalTo: centerXAnchor),

			cityLabel.topAnchor.constraint(equalTo: centerYAnchor, constant: 4),
			cityLabel.heightAnchor.constraint(equalToConstant: 25),
			cityLabel.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor),
			cityLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

			changeCityButton.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 4),
			changeCityButton.heightAnchor.constraint(equalToConstant: 40),
			changeCityButton.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor),
			changeCityButton.centerXAnchor.constraint(equalTo: centerXAnchor),

			acceptButton.topAnchor.constraint(equalTo: changeCityButton.bottomAnchor, constant: 40),
			acceptButton.heightAnchor.constraint(equalToConstant: 40),
			acceptButton.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor),
			acceptButton.centerXAnchor.constraint(equalTo: centerXAnchor)
		])
	}

	func showCitiesList(list: [Any]) {
		
	}
}

/// Actions
extension LocationView {
	@objc private func acceptButtonTapped() {
		output?.acceptButtonTapped()
	}

	@objc private func repeatButtonTapped() {
		output?.repeatButtonTapped()
	}

	@objc private func changeCityButtonTapped() {
		output?.changeCityButtonTapped()
	}

	@objc private func changeCountryButtonTapped() {
		output?.changeCountryButtonTapped()
	}
}
extension LocationView: LocationViewInput {
	func set(location: LocationModel) {
		cityLabel.text = location.city
		countryLabel.text = location.country
	}
}
