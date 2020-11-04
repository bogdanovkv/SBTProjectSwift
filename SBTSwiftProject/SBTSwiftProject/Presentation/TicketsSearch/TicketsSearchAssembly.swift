//
//  TicketsSearchAssembly.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 04.11.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import UIKit

protocol TicketsSearchAssemblyProtocol {
	func createViewController(with city: CityModel, coutry: CountryModel) -> UIViewController
}

class TicketsSearchAssembly: TicketsSearchAssemblyProtocol {
	func createViewController(with city: CityModel, coutry: CountryModel) -> UIViewController {
		let interactor = TicketsSearchInteractor()
		let router = TicketsSearchRouter(selectCountryAssembly: SelectCountryAssembly(),
										 selectCityAssembly: SelectCityAssembly())
		let controller = TicketsSearchViewController(departureCity: city,
													 departureCountry: coutry,
													 interactor: interactor,
													 router: router)
		interactor.output = controller
		return controller
	}
}
