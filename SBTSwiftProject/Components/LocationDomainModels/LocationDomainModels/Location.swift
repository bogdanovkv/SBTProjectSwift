//
//  LocationModel.swift
//
//  Created by Константин Богданов on 18.04.2021.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import Foundation

/// Модель местоположения
public struct Location {

	/// Название страны
	public let country: String

	/// Название города
	public let city: String

	/// Инициализатор
	/// - Parameters:
	///   - country: название страны
	///   - city: название города
	public init(country: String, city: String) {
		self.city = city
		self.country = country
	}
}
