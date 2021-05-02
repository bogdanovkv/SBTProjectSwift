//
//  SettingsViewController.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 07.11.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import UIKit

protocol SettingsModuleInput {
	var moduleOutput: SettingsModuleOuput? { get set }
}

protocol SettingsModuleOuput {

}

/// Контроллер настроек
final class SettingsViewController: UIViewController, SettingsModuleInput {
	var moduleOutput: SettingsModuleOuput?

	private lazy var settingsView = SettingsView()

	init() {
		super.init(nibName: nil, bundle: nil)
		title = "Настройки"
		tabBarItem = .init(tabBarSystemItem: .more, tag: 0)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func loadView() {
		view = settingsView
	}

    override func viewDidLoad() {
        super.viewDidLoad()
    }

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.setNavigationBarHidden(true, animated: animated)
	}
}
