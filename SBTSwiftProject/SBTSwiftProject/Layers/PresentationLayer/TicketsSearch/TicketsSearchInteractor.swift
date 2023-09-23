//
//  TicketsSearchInteractor.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 03.11.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import Foundation
import DomainAbstractions
import TicketsDomain
import LocationDomain
import LocationDomainModels

/// Ouptut интерактора поиска билетов
protocol TicketsSearchInteractorOutput: AnyObject {

	/// Получены билеты
	/// - Parameter tickets: билеты
	func didRecieve(tickets: [Ticket])

	/// Получена ошибка во время поиска по билетам
	/// - Parameter error: ошибка
	func didRecieve(error: Error)
}

/// Протокол интерактора поиска билетов
protocol TicketsSearchInteractorInput {

	/// Запускает поиск билетов
	/// - Parameters:
	///   - fromCity: город отправлени
	///   - fromDate: дата отправления
	///   - toCity: город прибытия
	///   - returnDate: дата возврата назад
	func searchTickets(fromCity: City,
					   fromDate: Date?,
					   toCity: City,
					   returnDate: Date?)

	/// Получает страну по коду
	/// - Parameter name: название
	func getCountry(with codeIATA: String) -> Country?

	/// Получает город по коду
	/// - Parameter codeIATA: код города
	func getCity(with codeIATA: String) -> City?
}

/// Интерактор поиска по билетам
final class TicketsSearchInteractor: TicketsSearchInteractorInput {

	/// Обработчик событий от интерактора
	var output: TicketsSearchInteractorOutput?

	private let searchTicketsUseCase: any UseCaseAsync<TicketsSearchModel, Result<[Ticket], Error>>
	private let getCountryByCodeUseCase: any UseCase<String, Country?>
	private let getCityByCodeUseCase: any UseCase<String, City?>

	/// Инициализатор
	/// - Parameter searchTicketsUseCase: кейс поиска билетов
	init(searchTicketsUseCase: any UseCaseAsync<TicketsSearchModel, Result<[Ticket], Error>>,
		 getCountryByCodeUseCase: any UseCase<String, Country?>,
		 getCityByCodeUseCase: any UseCase<String, City?>) {
		self.searchTicketsUseCase = searchTicketsUseCase
		self.getCountryByCodeUseCase = getCountryByCodeUseCase
		self.getCityByCodeUseCase = getCityByCodeUseCase
	}

	func searchTickets(fromCity: City,
					   fromDate: Date?,
					   toCity: City,
					   returnDate: Date?) {
		Task {
			do {
				let result = try await searchTicketsUseCase.execute(input: .init(fromCityCodeIATA: fromCity.codeIATA,
																				 fromDate: fromDate,
																				 toCityCodeIATA: toCity.codeIATA,
																				 returnDate: returnDate)).get()
				self.output?.didRecieve(tickets: result)
			} catch {
				self.output?.didRecieve(error: error)
			}
		}
	}

	func getCountry(with codeIATA: String) -> Country? {
		return getCountryByCodeUseCase.execute(input: codeIATA)
	}

	func getCity(with codeIATA: String) -> City? {
		return getCityByCodeUseCase.execute(input: codeIATA)
	}
}
