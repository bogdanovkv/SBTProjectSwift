//
//  SettingsView.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 27.12.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import UIKit

final class SettingsView: UIView {

	private let searchField: UITextField
	private let tableView: UITableView

	init() {
		searchField = .init(frame: .zero)
		searchField.translatesAutoresizingMaskIntoConstraints = false
		searchField.backgroundColor = .gray

		tableView = .init(frame: .zero)
		tableView.translatesAutoresizingMaskIntoConstraints = false
		super.init(frame: .zero)
		backgroundColor = .white
		setupViews()
		setupConstraints()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func setupViews() {
		addSubview(searchField)
		addSubview(tableView)
	}

	private func setupConstraints() {
		NSLayoutConstraint.activate([
			searchField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 4),
			searchField.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 8),
			searchField.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -8),

			tableView.topAnchor.constraint(equalTo: searchField.bottomAnchor, constant: 4),
			tableView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
			tableView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
			tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
		])
	}
}
