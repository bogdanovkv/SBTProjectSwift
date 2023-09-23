//
//  TicketInteractor.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 01.05.2021.
//  Copyright © 2021 Константин Богданов. All rights reserved.
//

import DomainAbstractions
import LocationDomain
import LocationDomainModels

/// Интерактор экрана отображения информации о билете
protocol TicketInteractorInput {

	/// Получает город по коду
	/// - Parameter code: код
	func getCity(by code: String) -> City?

	/// Получает страну по коду
	/// - Parameter code: коду
	func getCountry(by code: String) -> Country?
}

final class TicketInteractor: TicketInteractorInput {

	private let getCityByCodeUseCase: any UseCase<String, City?>
	private let getCountryByCodeUseCase: any UseCase<String, Country?>

	init(getCityByCodeUseCase: any UseCase<String, City?>,
		 getCountryByCodeUseCase: any UseCase<String, Country?>) {
		self.getCityByCodeUseCase = getCityByCodeUseCase
		self.getCountryByCodeUseCase = getCountryByCodeUseCase
	}

	func getCity(by code: String) -> City? {
		return getCityByCodeUseCase.execute(input: code)
	}

	func getCountry(by code: String) -> Country? {
		return getCountryByCodeUseCase.execute(input: code)
	}
}
