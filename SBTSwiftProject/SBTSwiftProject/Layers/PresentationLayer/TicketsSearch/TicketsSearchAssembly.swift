//
//  TicketsSearchAssembly.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 04.11.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import UIKit
import LocationDomain
import DomainAbstractions
import TicketsDomain
import LocationDomainModels

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
