//
//  SelectCityAssembly.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 02.11.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import UIKit

protocol SelectCityAssemblyProtocol {
	func createController(country: CountryModel) -> UIViewController & SelectCityViewControllerInput
}

final class SelectCityAssembly: SelectCityAssemblyProtocol {

	func createController(country: CountryModel) -> UIViewController & SelectCityViewControllerInput {
		let interactor = SelectCityInteractor()
		let controller = SelectCityViewController(interactor: interactor, country: country)
		return controller
	}
}
