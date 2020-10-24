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
	func set(location: LocationModel)
}

final class LocationView: UIView {

	weak var output: LocationViewOutput?

	private let cityLabel: UILabel
	private let countryLabel: UILabel
	private let changeCityButton: UIButton
	private let changeCountryButton: UIButton

	init() {
		cityLabel = .init(frame: .zero)
		cityLabel.translatesAutoresizingMaskIntoConstraints = false
		cityLabel.textColor = .black
		cityLabel.layer.borderColor = UIColor.black.cgColor
		cityLabel.layer.cornerRadius = 4
		cityLabel.layer.borderWidth = 2

		countryLabel = .init(frame: .zero)
		countryLabel.translatesAutoresizingMaskIntoConstraints = false
		countryLabel.layer.borderColor = UIColor.black.cgColor
		countryLabel.layer.cornerRadius = 4
		countryLabel.layer.borderWidth = 2

		changeCityButton = .init()
		changeCityButton.translatesAutoresizingMaskIntoConstraints = false
		changeCityButton.setTitle("Изменить город", for: .normal)
		changeCityButton.setTitleColor(.black, for: .normal)

		changeCountryButton = .init()
		changeCountryButton.translatesAutoresizingMaskIntoConstraints = false
		changeCountryButton.setTitle("Изменить страну", for: .normal)
		changeCountryButton.setTitleColor(.black, for: .normal)

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
		changeCountryButton.addTarget(self, action: #selector(changeCountryButtonTapped), for: .touchUpInside)
		changeCityButton.addTarget(self, action: #selector(changeCityButtonTapped), for: .touchUpInside)
	}

	private func setupSubviews() {
		addSubview(cityLabel)
		addSubview(countryLabel)
		addSubview(changeCityButton)
		addSubview(changeCountryButton)
	}

	private func setupContraints() {
		NSLayoutConstraint.activate([
			cityLabel.bottomAnchor.constraint(equalTo: changeCityButton.topAnchor, constant: -4),
			cityLabel.heightAnchor.constraint(equalToConstant: 25),
			cityLabel.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor),
			cityLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

			changeCityButton.bottomAnchor.constraint(equalTo: centerYAnchor, constant: -4),
			changeCityButton.heightAnchor.constraint(equalToConstant: 40),
			changeCityButton.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor),
			changeCityButton.centerXAnchor.constraint(equalTo: centerXAnchor),

			countryLabel.topAnchor.constraint(equalTo: centerYAnchor, constant: 4),
			countryLabel.heightAnchor.constraint(equalToConstant: 25),
			countryLabel.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor),
			countryLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

			changeCountryButton.topAnchor.constraint(equalTo: countryLabel.bottomAnchor, constant: 4),
			changeCountryButton.heightAnchor.constraint(equalToConstant: 40),
			changeCountryButton.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor),
			changeCountryButton.centerXAnchor.constraint(equalTo: centerXAnchor),
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
