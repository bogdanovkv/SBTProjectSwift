//
//  LocationView.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 24.10.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import UIKit
import LocationDomainModels
import LocationDomain

/// Обработчик событий от вью выбора местоположения
protocol LocationViewOutput: AnyObject {

	/// Нажата кнопка повторить
	func repeatButtonTapped()

	/// Нажата кнопка выбора города
	func changeCityButtonTapped()

	/// Нажата кнопка подтверждения выбора
	func acceptButtonTapped()

	/// Нажата кнопка выбора страны
	func changeCountryButtonTapped()
}

/// Протокол вью выбора местоположения
protocol LocationViewInput: UIView {

	/// Обработчик событий от вью
	var output: LocationViewOutput? { get set }

	/// Устанавливает местоположение
	/// - Parameter location: местоположение
	func set(location: LocationModel)

	/// Показать состояние с ошибкой выбора города
	func showCityErrorState()

	/// Показать состояние с ошибкой выбора страны
	func showCountryErrorState()

	/// Показать лоадер
	func showLoader()

	/// Показать лоадер
	func hideLoader()

}

final class LocationView: UIView {

	var output: LocationViewOutput?

	private let titleLabel: UILabel
	private let countryLabel: UILabel
	private let cityLabel: UILabel
	private let changeCountryButton: UIButton
	private let changeCityButton: UIButton
	private let acceptButton: UIButton
	private let loader: UIActivityIndicatorView

	init() {
		titleLabel = .init(frame: .zero)
		titleLabel.text = "Выберите ваше местоположение"
		titleLabel.translatesAutoresizingMaskIntoConstraints = false
		titleLabel.textColor = .black

		countryLabel = .init(frame: .zero)
		countryLabel.translatesAutoresizingMaskIntoConstraints = false
		countryLabel.textColor = .black
		countryLabel.layer.borderColor = UIColor.black.cgColor
		countryLabel.layer.cornerRadius = 4
		countryLabel.layer.borderWidth = 2
		countryLabel.textAlignment = .center

		cityLabel = .init(frame: .zero)
		cityLabel.translatesAutoresizingMaskIntoConstraints = false
		cityLabel.layer.borderColor = UIColor.black.cgColor
		cityLabel.layer.cornerRadius = 4
		cityLabel.layer.borderWidth = 2
		cityLabel.textAlignment = .center

		changeCountryButton = .init()
		changeCountryButton.translatesAutoresizingMaskIntoConstraints = false
		changeCountryButton.setTitle(" Изменить страну ", for: .normal)
		changeCountryButton.setTitleColor(.black, for: .normal)
		changeCountryButton.backgroundColor = .gray
		changeCountryButton.layer.cornerRadius = 8

		changeCityButton = .init()
		changeCityButton.translatesAutoresizingMaskIntoConstraints = false
		changeCityButton.setTitle(" Изменить город ", for: .normal)
		changeCityButton.setTitleColor(.black, for: .normal)
		changeCityButton.setTitleColor(.gray, for: .highlighted)
		changeCityButton.backgroundColor = .gray
		changeCityButton.layer.cornerRadius = 8

		acceptButton = .init()
		acceptButton.translatesAutoresizingMaskIntoConstraints = false
		acceptButton.setTitle(" Выбрать ", for: .normal)
		acceptButton.setTitleColor(.black, for: .normal)
		acceptButton.setTitleColor(.gray, for: .highlighted)
		acceptButton.backgroundColor = .gray
		acceptButton.layer.cornerRadius = 8

		loader = .init()
		loader.translatesAutoresizingMaskIntoConstraints = false
		loader.activityIndicatorViewStyle = .large
		loader.isHidden = true
		loader.backgroundColor = .init(red: 0, green: 0, blue: 0, alpha: 0.25)

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
		addSubview(loader)
	}

	private func setupContraints() {
		titleLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
		countryLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
		cityLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
		changeCountryButton.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
		changeCityButton.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
		NSLayoutConstraint.activate([
			titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 25),
			titleLabel.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor),
			titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
			titleLabel.bottomAnchor.constraint(equalTo: countryLabel.topAnchor, constant: -16),

			countryLabel.bottomAnchor.constraint(equalTo: changeCountryButton.topAnchor, constant: -4),
			countryLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 36),
			countryLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
			countryLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
			countryLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

			changeCountryButton.bottomAnchor.constraint(equalTo: centerYAnchor, constant: -8),
			changeCountryButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 40),
			changeCountryButton.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor),
			changeCountryButton.centerXAnchor.constraint(equalTo: centerXAnchor),

			cityLabel.topAnchor.constraint(equalTo: centerYAnchor, constant: 8),
			cityLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 35),
			cityLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
			cityLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
			cityLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

			changeCityButton.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 4),
			changeCityButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 40),
			changeCityButton.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor),
			changeCityButton.centerXAnchor.constraint(equalTo: centerXAnchor),

			acceptButton.topAnchor.constraint(equalTo: changeCityButton.bottomAnchor, constant: 40),
			acceptButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 40),
			acceptButton.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor),
			acceptButton.centerXAnchor.constraint(equalTo: centerXAnchor),

			loader.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
			loader.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
			loader.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
			loader.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)])
	}

	private func borderAnimation() -> CABasicAnimation {
		let borderAnimation = CABasicAnimation(keyPath: "borderWidth")
		borderAnimation.autoreverses = true
		borderAnimation.duration = 0.4
		borderAnimation.toValue = 4
		borderAnimation.fromValue = 2
		return borderAnimation
	}

	private func borderColorAnimation() -> CABasicAnimation {
		let colorAnimation = CABasicAnimation(keyPath: "borderColor")
		colorAnimation.autoreverses = true
		colorAnimation.duration = 0.4
		colorAnimation.toValue = UIColor(red: 1, green: 0, blue: 0, alpha: 1).cgColor
		colorAnimation.fromValue = UIColor.black.cgColor
		return colorAnimation
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
	func showLoader() {
		loader.isHidden = false
		loader.startAnimating()
	}

	func hideLoader() {
		loader.isHidden = true
		loader.stopAnimating()
	}

	func showCityErrorState() {
		cityLabel.layer.add(borderAnimation(), forKey: nil)
		cityLabel.layer.add(borderColorAnimation(), forKey: nil)
	}

	func showCountryErrorState() {
		countryLabel.layer.add(borderAnimation(), forKey: nil)
		countryLabel.layer.add(borderColorAnimation(), forKey: nil)
	}

	func resetErrorsState() {
		cityLabel.layer.backgroundColor = UIColor.black.cgColor
		cityLabel.layer.borderWidth = 2
		countryLabel.layer.backgroundColor = UIColor.black.cgColor
		countryLabel.layer.borderWidth = 2
	}

	func set(location: LocationModel) {
		cityLabel.text = location.city
		countryLabel.text = location.country
	}
}
