//
//  TiketViewControllerAssembly.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 21.11.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import UIKit
import LocationDomainAbstraction
import DomainAbstraction
import TicketsDomainAbstraction

final class TicketAssembly: TicketAssemblyProtocol {
	private let getCityByCodeUseCase: UseCaseSync<String, City?>
	private let getCountryByCodeUseCase: UseCaseSync<String, Country?>

	init(getCityByCodeUseCase: UseCaseSync<String, City?>,
		 getCountryByCodeUseCase: UseCaseSync<String, Country?>) {
		self.getCityByCodeUseCase = getCityByCodeUseCase
		self.getCountryByCodeUseCase = getCountryByCodeUseCase
	}

	func createViewCotroller(for tiket: TicketPresentationModel) -> UIViewController & TicketModuleInput {
		let interactor = TicketInteractor(getCityByCodeUseCase: getCityByCodeUseCase,
										  getCountryByCodeUseCase: getCountryByCodeUseCase)
		let controller = TicketViewController(viewModel: .init(ticket: tiket),
											  interactor: interactor)
		return controller
	}
}
