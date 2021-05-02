//
//  TiketViewControllerAssembly.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 21.11.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import UIKit
import Inject
import LocationDomainAbstraction
import TicketsDomainAbstraction


final class TiketViewControllerAssembly: TiketAssemblyProtocol {
	func createViewCotroller(for tiket: TicketPresentationModel) -> UIViewController & TicketModuleInput {
		let getCityByCodeUseCase = Inject.domainLayer.create(closure: { $0.createGetCityByCodeUseCase() }, strategy: .new)
		let getCountryByCodeUseCase = Inject.domainLayer.create(closure: { $0.createGetCountryByCodeUseCase() }, strategy: .new)
		let interactor = TicketInteractor(getCityByCodeUseCase: getCityByCodeUseCase,
										  getCountryByCodeUseCase: getCountryByCodeUseCase)
		let controller = TicketViewController(viewModel: .init(ticket: tiket),
											  interactor: interactor)
		return controller
	}
}
