//
//  DataLayerDependencies.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 24.10.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import Inject
import TicketsRepositoryAbstraction
import TicketsRepository
import LocationRepositoryAbstraction
import LocationRepository

extension Inject where FactoryType == DataLayerDependencies {
	static var dataLayer: Inject<DataLayerDependencies> {
		return .init(factory: DataLayerDependencies.self)
	}
}

struct DataLayerDependencies: InjectFactoryProtocol {
	static var scope = "dataLayer"
	static func createLocationRepository() -> LocationRepositoryProtocol {
		let networkService = Inject.serviceLayer.create(closure: { $0.createNetworkService() },
															 strategy: .new)
		let coreDataService = Inject.serviceLayer.create(closure: { $0.createCoreDataService() },
														strategy: .single)
		return LocationRepository(networkService: networkService,
								  coreDataService: coreDataService)
	}

	static func createSettingsRepository() -> UserSettingsRepository {
		return UserSettingsRepository()
	}

	static func createTicketsRepository() -> TicketsRepositoryProtocol {
		let service = Inject.serviceLayer.create(closure: { $0.createNetworkService() },
															 strategy: .new)
		return TicketsRepository(networkService: service)
	}
}
