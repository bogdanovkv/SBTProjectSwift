//
//  SelectCityViewController.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 02.11.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import UIKit
import LocationDomainAbstraction

protocol SelectCityModuleInput: AnyObject {
	var moduleOutput: SelectCityModuleOutput? { get set }
}

protocol SelectCityModuleOutput: AnyObject {
	func userSelectCity(with code: String)
}

final class SelectCityViewController: UIViewController, SelectCityModuleInput {

	weak var moduleOutput: SelectCityModuleOutput?
	private let countryCode: String
	private let interactor: SelectCityInteractorInput
	private lazy var tableView: UITableView = {
		return UITableView(frame: .zero, style: .plain)
	}()

	private var models: [City]

	init(interactor: SelectCityInteractorInput,
		 countryCode: String) {
		self.interactor = interactor
		self.countryCode = countryCode
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
		models = interactor.getCities(for: countryCode)
		tableView.reloadData()
    }

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.setNavigationBarHidden(true, animated: animated)
	}
}

extension SelectCityViewController: UITableViewDataSource {
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

extension SelectCityViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let model = models[indexPath.row]
		self.moduleOutput?.userSelectCity(with: model.codeIATA)
	}
}
