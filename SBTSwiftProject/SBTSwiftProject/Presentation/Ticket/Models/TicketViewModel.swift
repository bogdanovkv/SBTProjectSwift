//
//  TicketViewModel.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 21.11.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import UIKit
import LocationRepositoryAbstraction
final class TicketViewModel {

	let ticket: Ticket
	let departureCity: CityModel
	let departureCountry: CountryModel
	let destinationCity: CityModel
	let destinationCountry: CountryModel

	init(ticket: Ticket,
		 departureCity: CityModel,
		 departureCountry: CountryModel,
		 destinationCity: CityModel,
		 destinationCountry: CountryModel) {
		self.ticket = ticket
		self.departureCity = departureCity
		self.departureCountry = departureCountry
		self.destinationCity = destinationCity
		self.destinationCountry = destinationCountry
	}
}
