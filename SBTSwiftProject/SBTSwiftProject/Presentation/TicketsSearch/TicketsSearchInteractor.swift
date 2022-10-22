//
//  TicketsSearchInteractor.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 03.11.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import Foundation

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
	func searchTickets(fromCity: CityModel,
					   fromDate: Date?,
					   toCity: CityModel,
					   returnDate: Date?)
}

/// Интерактор поиска по билетам
final class TicketsSearchInteractor: TicketsSearchInteractorInput {

	/// Обработчик событий от интерактора
	weak var output: TicketsSearchInteractorOutput?

	private let searchTicketsUseCase: UseCase<TicketsSearchModel, [Ticket]>

	/// Инициализатор
	/// - Parameter searchTicketsUseCase: кейс поиска билетов
	init(searchTicketsUseCase: UseCase<TicketsSearchModel, [Ticket]> ) {
		self.searchTicketsUseCase = searchTicketsUseCase
	}

	func searchTickets(fromCity: CityModel,
					   fromDate: Date?,
					   toCity: CityModel,
					   returnDate: Date?) {
		searchTicketsUseCase.execute(parameter: .init(fromCity: fromCity,
													  fromDate: fromDate,
													  toCity: toCity,
													  returnDate: returnDate)) { [weak self] result in
			do {
				let result = try result.get()
				DispatchQueue.main.async {
					self?.output?.didRecieve(tickets: result)
				}
			} catch {
				DispatchQueue.main.async {
					self?.output?.didRecieve(error: error)
				}
			}
		}
	}
}
