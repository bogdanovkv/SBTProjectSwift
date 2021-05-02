//
//  SelectCityCoordinatorAssembly.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 02.05.2021.
//  Copyright © 2021 Константин Богданов. All rights reserved.
//

import UIKit

/// Сборщик координатора экрана выбора города
protocol SelectCityCoordinatorAssemblyProtocol {

	/// Создает координатор
	/// - Parameters:
	///   - router: роутер
	///   - selectCityAssembly: сборщик экрана
	func createCoordinator(router: RouterProtocol, selectCityAssembly: SelectCityAssemblyProtocol) -> Coordinator<String, String>
}

/// Сборщик координатора экрана выбора города
final class SelectCityCoordinatorAssembly {

	func createCoordinator(router: RouterProtocol, selectCityAssembly: SelectCityAssemblyProtocol) -> Coordinator<String, String> {
		return SelectCityCoordinator(router: router,
									 selectCityAssembly: selectCityAssembly)
	}

}
