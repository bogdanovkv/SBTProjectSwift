//
//  SelectCountryCoordinator.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 02.05.2021.
//  Copyright © 2021 Константин Богданов. All rights reserved.
//

import UIKit

final class SelectCountryCoordinator: Coordinator<Void, String> {
	private let selectCountryAssembly: SelectCountryAssemblyProtocol
	private let router: RouterProtocol
	private var module: SelectCountryModuleInput?

	/// Инициализатор
	/// - Parameters:
	///   - router: роутер
	///   - selectCountryAssembly: сборщик экрана выбора города
	init(router: RouterProtocol,
		 selectCountryAssembly: SelectCountryAssemblyProtocol) {
		self.router = router
		self.selectCountryAssembly = selectCountryAssembly
	}

	override func start(parameter: Void) {
		let module = selectCountryAssembly.createController()
		self.module = module
		module.output = self
		router.present(module)
	}
}

extension SelectCountryCoordinator: SelectCountryModuleOutput {
	func userSelectCountry(with code: String) {
		router.dismiss { [weak self] in
			self?.finishFlow?(code)
		}
	}
}
