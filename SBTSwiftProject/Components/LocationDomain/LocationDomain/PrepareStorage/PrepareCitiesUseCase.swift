//
//  PrepareCitiesUseCase.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 31.10.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import DomainAbstractions
import LocationDomainModels

final class PrepareCitiesUseCase: UseCaseAsync {

	private let repository: CitiesRepositoryProtocol

	init(repository: CitiesRepositoryProtocol) {
		self.repository = repository
	}

	func execute(input: Void) async -> Result<Void, Error> {
		return await withCheckedContinuation { continuation in
			repository.loadCities { result in
				if let cities = try? result.get() {
					self.repository.save(cities: cities) {
						continuation.resume(returning: .success(()))
					}
					return
				}
				continuation.resume(returning: .failure(LocationError.undefined))
			}
		}
	}
}
