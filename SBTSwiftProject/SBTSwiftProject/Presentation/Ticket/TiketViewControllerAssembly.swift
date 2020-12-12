//
//  TiketViewControllerAssembly.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 21.11.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import UIKit

protocol TiketAssemblyProtocol {
	func createViewCotroller(with tiket: Ticket,
							 departureLocation:(country: CountryModel, city: CityModel),
							 destinationLocation:(country: CountryModel, city: CityModel)) -> UIViewController
}

final class TiketViewControllerAssembly: TiketAssemblyProtocol {
	func createViewCotroller(with tiket: Ticket,
							 departureLocation:(country: CountryModel, city: CityModel),
							 destinationLocation:(country: CountryModel, city: CityModel)) -> UIViewController {
		let controller = TicketViewController(viewModel: .init(ticket: tiket,
															   departureCity: departureLocation.city,
															   departureCountry: departureLocation.country,
															   destinationCity: destinationLocation.city,
															   destinationCountry: destinationLocation.country))
		return controller
	}
}
