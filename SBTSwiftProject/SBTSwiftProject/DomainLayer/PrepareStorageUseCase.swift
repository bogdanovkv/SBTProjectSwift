//
//  PrepareStorageUseCase.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 24.10.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import Foundation

protocol PrepareStorageUseCaseProtocol {
	func prepareStorage(_ copmletion: (Result<Bool, Error>) -> Void)
}

class PrepareStorageUseCase: PrepareStorageUseCaseProtocol {

	private let locationRepository: LocationRepositoryProtocol

	init(locationRepository: LocationRepositoryProtocol) {
		self.locationRepository = locationRepository
	}

	func prepareStorage(_ copmletion: (Result<Bool, Error>) -> Void) {
		let group = DispatchGroup()

		group.enter()
		locationRepository.loadCities { result in
			if let cities = try? result.get() {
				// TODO: - save
			}

			group.leave()
		}
	}
}
