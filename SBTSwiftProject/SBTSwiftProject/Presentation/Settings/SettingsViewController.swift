//
//  SettingsViewController.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 07.11.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import UIKit

/// Контроллер настроек
final class SettingsViewController: UIViewController {

	init() {
		super.init(nibName: nil, bundle: nil)
		title = "Настройки"
		tabBarItem = .init(tabBarSystemItem: .more, tag: 0)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
