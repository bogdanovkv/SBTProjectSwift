//
//  CountryModel.swift
//  Entites
//
//  Created by Константин Богданов on 21.09.2023.
//

/// Модель страны
public struct CountryModel {

	/// Код страны
	public let codeIATA: String

	/// Название страны на английском
	public let name: String

	/// Название страны на русском
	public let nameRu: String?

	/// Инициализатор
	/// - Parameters:
	///   - codeIATA: код страны
	///   - name: название на английском
	///   - nameRu: название на русском
	public init(codeIATA: String,
				name: String,
				nameRu: String?) {
		self.codeIATA = codeIATA
		self.name = name
		self.nameRu = nameRu
	}
}
