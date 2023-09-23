//
//  CityModel.swift
//  Entites
//
//  Created by Константин Богданов on 21.09.2023.
//

/// Модель города
public struct CityModel {

	/// Код города
	public let codeIATA: String

	/// Код страны
	public let countryCode: String

	/// Название города на английском
	public let name: String

	/// Название на русском
	public let nameRu: String?

	/// Инициализатор
	/// - Parameters:
	///   - codeIATA: код города
	///   - countryCode: код страны
	///   - name: название города на английском
	///   - nameRu: название на русском
	public init(codeIATA: String,
		 countryCode: String,
		 name: String,
		 nameRu: String?) {
		self.codeIATA = codeIATA
		self.countryCode = countryCode
		self.name = name
		self.nameRu = nameRu
	}
}
