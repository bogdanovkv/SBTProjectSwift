//
//  TicketsSearchViewModel.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 04.11.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//
import Foundation
import TicketsDomain
import LocationDomain
import LocationDomainModels

/// Вью модель для экрана поиска билетов
final class TicketsSearchViewModel {
	var departureCountry: Country?
	var departureCity: City?
	var departureDate: Date?
	var desntinationCity: City?
	var desntinationCountry: Country?
	var returnDate: Date?
	var tickets: [Ticket] = []
}
