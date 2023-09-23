//
//  SelectCountryViewController.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 02.11.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import UIKit
import LocationDomain
import LocationDomainModels

/// Протокол контроллера выбора страны
protocol SelectCountryModuleInput: AnyObject {

	/// Обработчик событий от экрана выбора страны
	var moduleOutput: SelectCountryModuleOutput? { get set }
}

/// Протокол обработчика событий от экрана выбора страны
protocol SelectCountryModuleOutput: AnyObject {

	/// Пользователь выбрал страну
	/// - Parameter code: код страны
	func userSelectCountry(with code: String)
}

/// Контроллер выбора страны
final class SelectCountryViewController: UIViewController, SelectCountryModuleInput {

	weak var moduleOutput: SelectCountryModuleOutput?

	private let interactor: SelectCountryInteractorInput
	private lazy var tableView: UITableView = {
		return UITableView(frame: .zero, style: .plain)
	}()

	private var models: [Country]

	/// Инициализатор
	/// - Parameter interactor: интерактор
	init(interactor: SelectCountryInteractorInput) {
		self.interactor = interactor
		models = []
		super.init(nibName: nil, bundle: nil)
	}

	override func loadView() {
		view = tableView
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
		tableView.dataSource = self
		tableView.delegate = self

	}
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		models = interactor.getCountries()
		tableView.reloadData()
    }

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.setNavigationBarHidden(true, animated: animated)
	}
}

extension SelectCountryViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return models.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
		let ruName = models[indexPath.row].nameRu
		let name = models[indexPath.row].name
		cell.textLabel?.text = ruName ?? name
		return cell
	}
}

extension SelectCountryViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let model = models[indexPath.row]
		self.moduleOutput?.userSelectCountry(with: model.codeIATA)
	}
}
