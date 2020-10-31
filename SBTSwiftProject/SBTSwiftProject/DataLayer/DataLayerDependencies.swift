//
//  DataLayerDependencies.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 24.10.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import Inject

extension Inject {
	static var dataLayer: Inject<DataLayerDependencies> {
		return .init(factory: DataLayerDependencies.self)
	}
}

struct DataLayerDependencies: InjectFactoryProtocol {
	static var scope = "dataLayer"
	static func createLocationRepository() -> LocationRepositoryProtocol {
		return LocationRepository()
	}

	static func createSettingsRepository() -> UserSettingsRepository {
		return UserSettingsRepository()
	}
}
