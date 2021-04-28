//
//  SelectCityViewController.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 02.11.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import UIKit
import LocationDomainAbstraction

protocol SelectCityViewControllerInput: AnyObject {
	var output: SelectCityViewControllerOutput? { get set }
}

protocol SelectCityViewControllerOutput: AnyObject {
	func userSelect(city: City)
}

final class SelectCityViewController: UIViewController, SelectCityViewControllerInput {

	weak var output: SelectCityViewControllerOutput?
	private let country: Country
	private let interactor: SelectCityInteractorInput
	private lazy var tableView: UITableView = {
		return UITableView(frame: .zero, style: .plain)
	}()

	private var models: [City]

	init(interactor: SelectCityInteractorInput,
		 country: Country) {
		self.interactor = interactor
		self.country = country
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
		models = interactor.getCities(for: country)
		tableView.reloadData()
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
		cell.textLabel?.text = "\(ruName ?? "---")" + " " + "(\(name))"
		return cell
	}
}

extension SelectCityViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let model = models[indexPath.row]
		dismiss(animated: true, completion: {
			self.output?.userSelect(city: model)
		})
	}
}
