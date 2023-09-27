//
//  PresentationlayerComposer.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 02.05.2021.
//  Copyright © 2021 Константин Богданов. All rights reserved.
//

import UIKit

protocol PresentationLayerComposerProtocol {

	func composeAlertAssembly() -> AlertControllerAssemblyProtocol

	func composeSelectCountryAssembly() -> SelectCountryAssemblyProtocol

	func composeSelectCityAssembly() -> SelectCityAssemblyProtocol

	func composeSettingsAssembly() -> SettingsAssemblyProtocol

	func composeTicketsSearchAssembly() -> TicketsSearchAssemblyProtocol

	func composeTicketAssembly() -> TicketAssemblyProtocol

	func composeLocationAssembly() -> LocationAssemblyProtocol
}

final class PresentationLayerComposer: PresentationLayerComposerProtocol {

	private let domainLayerComposer: DomainLayerComposerProtocol

	init(domainLayerComposer: DomainLayerComposerProtocol) {
		self.domainLayerComposer = domainLayerComposer
	}

	func composeAlertAssembly() -> AlertControllerAssemblyProtocol {
		return AlertControllerAssembly()
	}

	func composeSelectCountryAssembly() -> SelectCountryAssemblyProtocol {
		return SelectCountryAssembly(getCountriesUseCase: domainLayerComposer.composeGetCountriesUseCase())
	}

	func composeSelectCityAssembly() -> SelectCityAssemblyProtocol {
		return SelectCityAssembly(getCitiesByCountryCodeUseCase: domainLayerComposer.composeGetCitiesByCountryCodeUseCase())
	}

	func composeSettingsAssembly() -> SettingsAssemblyProtocol {
		return SettingsAssembly()
	}

	func composeTicketsSearchAssembly() -> TicketsSearchAssemblyProtocol {
		return TicketsSearchAssembly(searchTicketsUseCase: domainLayerComposer.composeSearchTicketsUseCase(),
									 getCountryByCodeUseCase: domainLayerComposer.composeGetCountryByCodeUseCase(),
									 getCityByCodeUseCase: domainLayerComposer.composeGetCityByCodeUseCase())
	}

	func composeTicketAssembly() -> TicketAssemblyProtocol {
		return TicketAssembly(getCityByCodeUseCase: domainLayerComposer.composeGetCityByCodeUseCase(),
							  getCountryByCodeUseCase: domainLayerComposer.composeGetCountryByCodeUseCase())
	}

	func composeLocationAssembly() -> LocationAssemblyProtocol {
		return LocationAssembly(getLocationUseCase: domainLayerComposer.composeLocationUseCase(),
								getCountryUseCase: domainLayerComposer.composeGetCountryByNameUseCase(),
								getCityUseCase: domainLayerComposer.composeGetCityByNameUseCase(),
								prepareStorageUseCase: domainLayerComposer.composePrepareStorageUseCase(),
								getCityByCodeUseCase: domainLayerComposer.composeGetCityByCodeUseCase(),
								getCountryByCodeUseCase: domainLayerComposer.composeGetCountryByCodeUseCase())
	}
}
