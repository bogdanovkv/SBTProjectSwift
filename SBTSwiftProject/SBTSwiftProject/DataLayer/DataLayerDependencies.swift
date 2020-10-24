//
//  DataLayerDependencies.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 24.10.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//


struct DataLayerDependencies {

	static func createLocationRepository() -> LocationRepositoryProtocol {
		return LocationRepository(networkService: ServiceLayerDependecies.createNetworkService(),
								  coreDataService: ServiceLayerDependecies.createCoreDataService())
	}
}
