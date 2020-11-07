//
//  SettingsAssembly.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 07.11.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import UIKit

/// Протокол сборщик экрана настроек
protocol SettingsAssemblyProtocol {

	/// Создает экран настроек
	func createViewController() -> UIViewController
}

/// Сборщик экрана настроек
final class SettingsAssembly: SettingsAssemblyProtocol {

	func createViewController() -> UIViewController {
		return SettingsViewController()
	}
}
