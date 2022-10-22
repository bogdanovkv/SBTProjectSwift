//
//  DomainLayerDependencies.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 24.10.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import Inject

extension Inject where FactoryType == DomainLayerDependencies {
	static var domainLayer: Inject<DomainLayerDependencies> = .init(factory: DomainLayerDependencies.self)
}

struct DomainLayerDependencies: InjectFactoryProtocol {
	static var scope = "domainLayer"
	static func createLocationUseCase() -> LocationUseCaseProtocol {
		return LocationUseCase()
	}

	static func createPrepareStorageUseCase() -> PrepareStorageUseCaseProtocol {
		return PrepareStorageUseCase(prepareAirportsUseCase: PrepareAirportsUseCase(),
									 prepareCountriesUseCase: PrepareCountriesUseCase(),
									 prepareCitiesUseCase: PrepareCitiesUseCase())
	}

	static func createGetCountriesUseCase() -> UseCaseSync<Void, [CountryModel]> {
		return GetCountriesUseCase()
	}

	static func createGetCitiesUseCase() -> UseCaseSync<CountryModel, [CityModel]> {
		return GetCitiesUseCase()
	}

	static func createSearchTicketsUseCase() -> UseCase<TicketsSearchModel, [Ticket]> {
		return SearchTicketsUseCase()
	}
}
