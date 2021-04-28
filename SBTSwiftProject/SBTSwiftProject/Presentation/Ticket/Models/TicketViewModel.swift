//
//  TicketViewModel.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 21.11.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import UIKit
import LocationDomainAbstraction
import TicketsDomainAbstraction

final class TicketViewModel {

	let ticket: Ticket
	let departureCity: City
	let departureCountry: Country
	let destinationCity: City
	let destinationCountry: Country

	init(ticket: Ticket,
		 departureCity: City,
		 departureCountry: Country,
		 destinationCity: City,
		 destinationCountry: Country) {
		self.ticket = ticket
		self.departureCity = departureCity
		self.departureCountry = departureCountry
		self.destinationCity = destinationCity
		self.destinationCountry = destinationCountry
	}
}
