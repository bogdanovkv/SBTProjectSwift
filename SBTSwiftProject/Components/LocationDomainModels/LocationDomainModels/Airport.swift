//
//  AirportModel.swift
//
//  Created by Константин Богданов on 18.04.2021.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import Foundation

/// Модель аэропорта
public struct Airport {

	/// Код аэропорта
	public let code: String

	/// Название на английском
	public let name: String

	/// Код страны
	public let countryCode: String

	/// Код города
	public let cityCode: String

	/// Инициализатор
	/// - Parameters:
	///   - code: код аэропорта
	///   - name: название на английском
	///   - countryCode: код страны
	///   - cityCode: код города
	public init(code: String,
				name: String,
				countryCode: String,
				cityCode: String) {
		self.code = code
		self.name = name
		self.countryCode = countryCode
		self.cityCode = cityCode
	}
}
