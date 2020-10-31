//
//  DomainLayerDependencies.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 24.10.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import UIKit

struct DomainLayerDependencies {
	static func createLocationUseCase() -> LocationUseCaseProtocol {
		return LocationUseCase()
	}

	static func createPrepareStorageUseCase() -> PrepareStorageUseCaseProtocol {
		return PrepareStorageUseCase(settingsRepository: DataLayerDependencies.createSettingsRepository(),
									 prepareAirportsUseCase: PrepareAirportsUseCase(),
									 prepareCountriesUseCase: PrepareCountriesUseCase(),
									 prepareCitiesUseCase: PrepareCitiesUseCase())
	}
}
