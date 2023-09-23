//
//  PrepareCountriesUseCase.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 31.10.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import DomainAbstractions
import LocationDomainModels

final class PrepareCountriesUseCase: UseCaseAsync {
	private let repository: CountriesRepositoryProtocol

	init(repository: CountriesRepositoryProtocol) {
		self.repository = repository
	}

	func execute(input: Void) async -> Result<Void, Error> {
		return await withCheckedContinuation { continuation in
			repository.loadCountries { result in
				if let countries = try? result.get() {
					self.repository.save(countries: countries) {
						continuation.resume(returning: .success(()))
					}
					return
				}
				continuation.resume(returning: .failure(LocationError.undefined))
			}
		}
	}
}
