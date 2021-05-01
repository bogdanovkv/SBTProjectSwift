//
//  TicketsSearchInteractor.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 03.11.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import Inject
import DomainAbstraction
import TicketsDomainAbstraction
import LocationDomainAbstraction

/// Ouptut интерактора поиска билетов
protocol TicketsSearchInteractorOutput: AnyObject {

	/// Получены билеты
	/// - Parameter tickets: билеты
	func didRecieve(tickets: [Ticket])

	/// Получена ошибка во время поиска по билетам
	/// - Parameter error: ошибка
	func didRecieve(error: Error)

	/// Поучена страна
	/// - Parameter country: страна
	func didRecieve(country: Country)
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
	weak var output: TicketsSearchInteractorOutput?

	private let searchTicketsUseCase: UseCase<TicketsSearchModel, [Ticket]>
	private let getCountryByCodeUseCase: UseCaseSync<String, Country?>
	private let getCityByCodeUseCase: UseCaseSync<String, City?>

	/// Инициализатор
	/// - Parameter searchTicketsUseCase: кейс поиска билетов
	init(searchTicketsUseCase: UseCase<TicketsSearchModel, [Ticket]>,
		 getCountryByCodeUseCase: UseCaseSync<String, Country?>,
		 getCityByCodeUseCase: UseCaseSync<String, City?>) {
		self.searchTicketsUseCase = searchTicketsUseCase
		self.getCountryByCodeUseCase = getCountryByCodeUseCase
		self.getCityByCodeUseCase = getCityByCodeUseCase
	}

	/// Инициализатор с DI
	convenience init() {
		
		self.init(searchTicketsUseCase: Inject.domainLayer.create(closure: { $0.createSearchTicketsUseCase() },
																  strategy: .new),
				  getCountryByCodeUseCase: Inject.domainLayer.create(closure: { $0.createGetCountryByCodeUseCase() },
																	 strategy: .new),
				  getCityByCodeUseCase: Inject.domainLayer.create(closure: { $0.createGetCityByCodeUseCase() },
																  strategy: .new))
	}

	func searchTickets(fromCity: City,
					   fromDate: Date?,
					   toCity: City,
					   returnDate: Date?) {
		searchTicketsUseCase.execute(parameter: .init(fromCityCodeIATA: fromCity.codeIATA,
													  fromDate: fromDate,
													  toCityCodeIATA: toCity.codeIATA,
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

	func getCountry(with codeIATA: String) -> Country? {
		return getCountryByCodeUseCase.execute(parameter: codeIATA)
	}

	func getCity(with codeIATA: String) -> City? {
		return getCityByCodeUseCase.execute(parameter: codeIATA)
	}
}
