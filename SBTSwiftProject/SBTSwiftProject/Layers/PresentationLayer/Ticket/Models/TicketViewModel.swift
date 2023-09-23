//
//  TicketViewModel.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 21.11.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import UIKit
import LocationDomain
import TicketsDomain
import LocationDomainModels

/// Модель для view экрана отображения информации о билете
final class TicketViewModel {

	let ticket: TicketPresentationModel
	var departureCity: City?
	var departureCountry: Country?
	var destinationCity: City?
	var destinationCountry: Country?

	init(ticket: TicketPresentationModel) {
		self.ticket = ticket
	}
}
