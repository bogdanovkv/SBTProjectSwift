//
//  CountryModel.swift
//
//  Created by Константин Богданов on 18.04.2021.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import Foundation

/// Модель страны
public struct Country {

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
