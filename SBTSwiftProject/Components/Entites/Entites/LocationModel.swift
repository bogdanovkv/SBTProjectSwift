//
//  Location.swift
//  Entites
//
//  Created by Константин Богданов on 21.09.2023.
//

/// Модель местоположения
public struct LocationModel {

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
