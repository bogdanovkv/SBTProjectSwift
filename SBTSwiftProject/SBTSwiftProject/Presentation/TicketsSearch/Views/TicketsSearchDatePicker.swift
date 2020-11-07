//
//  TicketsSearchDatePicker.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 04.11.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import UIKit

/// Пикер для выбора даты
final class TicketsSearchDatePicker: UIView {

	private let okButton: UIButton
	private let picker: UIDatePicker
	private let action: (Date) -> Void

	/// Инициализатор
	/// - Parameter action: блок, куда будет передана дата при выборе
	init(action: @escaping (Date) -> Void) {
		okButton = .init()
		okButton.translatesAutoresizingMaskIntoConstraints = false
		okButton.setTitle("OK", for: .normal)
		okButton.setTitleColor(.black, for: .normal)
		okButton.setTitleColor(.gray, for: .highlighted)

		picker = .init()
		picker.datePickerMode = .date
		picker.minuteInterval = 30
		picker.minimumDate = .init()
		picker.translatesAutoresizingMaskIntoConstraints = false
		picker.tintColor = .black

		self.action = action

		super.init(frame: .zero)

		backgroundColor = .white
		setupAction()
		setupView()
		setupConstraints()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func setupAction() {
		okButton.addTarget(self, action: #selector(okButtonTapped), for: .touchUpInside)
	}

	private func setupView() {
		addSubview(okButton)
		addSubview(picker)
	}

	private func setupConstraints() {
		NSLayoutConstraint.activate([
			okButton.topAnchor.constraint(equalTo: topAnchor),
			okButton.leftAnchor.constraint(equalTo: leftAnchor),
			okButton.rightAnchor.constraint(equalTo: rightAnchor),
			okButton.heightAnchor.constraint(equalToConstant: 30),

			picker.topAnchor.constraint(equalTo: okButton.bottomAnchor),
			picker.leftAnchor.constraint(equalTo: leftAnchor),
			picker.heightAnchor.constraint(equalToConstant: 360),
			picker.rightAnchor.constraint(equalTo: rightAnchor),
			picker.bottomAnchor.constraint(equalTo: bottomAnchor)])
	}

	@objc private func okButtonTapped() {
		action(picker.date)
	}
}
