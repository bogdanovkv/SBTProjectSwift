//
//  TiketViewControllerAssembly.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 21.11.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import UIKit
import DomainAbstractions
import TicketsDomain
import LocationDomainModels

final class TicketAssembly: TicketAssemblyProtocol {
	private let getCityByCodeUseCase: any UseCase<String, City?>
	private let getCountryByCodeUseCase: any UseCase<String, Country?>

	init(getCityByCodeUseCase: any UseCase<String, City?>,
		 getCountryByCodeUseCase: any UseCase<String, Country?>) {
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
