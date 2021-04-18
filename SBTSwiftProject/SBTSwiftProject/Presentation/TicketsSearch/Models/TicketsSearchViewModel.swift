//
//  TicketsSearchViewModel.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 04.11.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//
import Foundation
import LocationRepositoryAbstraction

/// Вью модель для экрана поиска билетов
final class TicketsSearchViewModel {
	var departureCountry: CountryModel?
	var departureCity: CityModel?
	var departureDate: Date?
	var desntinationCity: CityModel?
	var desntinationCountry: CountryModel?
	var returnDate: Date?
	var tickets: [Ticket] = []
}
