//
//  TiketViewControllerAssembly.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 21.11.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import UIKit
import LocationDomainAbstraction
import TicketsDomainAbstraction

protocol TiketAssemblyProtocol {
	func createViewCotroller(with tiket: Ticket,
							 departureLocation:(country: Country, city: City),
							 destinationLocation:(country: Country, city: City)) -> UIViewController
}

final class TiketViewControllerAssembly: TiketAssemblyProtocol {
	func createViewCotroller(with tiket: Ticket,
							 departureLocation:(country: Country, city: City),
							 destinationLocation:(country: Country, city: City)) -> UIViewController {
		let controller = TicketViewController(viewModel: .init(ticket: tiket,
															   departureCity: departureLocation.city,
															   departureCountry: departureLocation.country,
															   destinationCity: destinationLocation.city,
															   destinationCountry: destinationLocation.country))
		return controller
	}
}
