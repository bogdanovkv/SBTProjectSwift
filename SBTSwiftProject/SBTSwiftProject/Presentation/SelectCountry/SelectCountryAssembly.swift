//
//  SelectCountryAssembly.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 02.11.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import UIKit

protocol SelectCountryAssemblyProtocol {
	func createController() -> UIViewController & SelectCountryViewControllerInput
}

class SelectCountryAssembly: SelectCountryAssemblyProtocol {

	func createController() -> UIViewController & SelectCountryViewControllerInput {
		let interactor = SelectCountryInteractor()
		let controller = SelectCountryViewController(interactor: interactor)
		return controller
	}
}
