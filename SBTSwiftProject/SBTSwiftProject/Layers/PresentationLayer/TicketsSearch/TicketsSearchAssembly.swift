//
//  TicketsSearchAssembly.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 04.11.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import UIKit
import LocationDomainAbstraction
import DomainAbstraction
import TicketsDomainAbstraction

/// Протокол сборщика экрана поиска билетов
protocol TicketsSearchAssemblyProtocol {

	/// Создает контроллер
	/// - Parameters:
	///   - city: город пользователя
	///   - coutry: страна пользователя
	func createViewController(with cityCode: String, coutryCode: String) -> UIViewController & TicketsSearchModuleInput
}

/// Сборщик экрана поиска билетов
final class TicketsSearchAssembly: TicketsSearchAssemblyProtocol {
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

	func createViewController(with cityCode: String, coutryCode: String) -> UIViewController & TicketsSearchModuleInput {
		let interactor = TicketsSearchInteractor(searchTicketsUseCase: searchTicketsUseCase,
												 getCountryByCodeUseCase: getCountryByCodeUseCase,
												 getCityByCodeUseCase: getCityByCodeUseCase)
		let controller = TicketsSearchViewController(departureCityCode: cityCode,
													 departureCountryCode: coutryCode,
													 interactor: interactor)
		interactor.output = controller
		return controller
	}
}
