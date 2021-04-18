//
//  TicketsSearchModel.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 04.11.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import Foundation
import LocationRepositoryAbstraction

/// Модель для поиска билетов
struct TicketsSearchModel {

	/// Город отправления
	let fromCity: CityModel

	/// Дата отправления
	let fromDate: Date?

	/// Город назначения
	let toCity: CityModel

	/// Дата возвращения обратно
	let returnDate: Date?
}
