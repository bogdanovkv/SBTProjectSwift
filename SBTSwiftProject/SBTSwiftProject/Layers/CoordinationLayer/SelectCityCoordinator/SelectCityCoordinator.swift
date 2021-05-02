//
//  SelectCityCoordinator.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 02.05.2021.
//  Copyright © 2021 Константин Богданов. All rights reserved.
//

import UIKit

final class SelectCityCoordinator: Coordinator<String, Result<String, Error>> {

	private let selectCityAssembly: SelectCityAssemblyProtocol
	private let router: RouterProtocol
	private var module: SelectCityModuleInput?

	/// Инициализатор
	/// - Parameters:
	///   - router: роутер
	///   - selectCityAssembly: сборщик экрана выбора города
	init(router: RouterProtocol,
		 selectCityAssembly: SelectCityAssemblyProtocol) {
		self.router = router
		self.selectCityAssembly = selectCityAssembly
	}

	override func start(parameter: String) {
		let module = selectCityAssembly.createController(countryCode: parameter)
		self.module = module
		module.moduleOutput = self
		router.present(module)
	}
}

extension SelectCityCoordinator: SelectCityModuleOutput {
	func userSelectCity(with code: String) {
		router.dismiss { [weak self] in
			self?.finishFlow?(.success(code))
		}
	}
}
