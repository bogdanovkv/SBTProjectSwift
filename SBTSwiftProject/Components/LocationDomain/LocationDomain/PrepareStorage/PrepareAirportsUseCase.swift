//
//  PrepareAirportsUseCase.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 31.10.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import LocationDomainModels
import DomainAbstractions

final class PrepareAirportsUseCase: UseCaseAsync {

	private let repository: AirportsRepositoryProtocol

	init(repository: AirportsRepositoryProtocol) {
		self.repository = repository
	}

	func execute(input: Void) async -> Result<Void, Error> {
		return await withCheckedContinuation { continuation in
			repository.loadAirports { [weak self] result in
				guard let self = self else {
					return continuation.resume(returning: .failure(LocationError.undefined))
				}
				if let airports = try? result.get() {
					self.repository.save(airports: airports) {
						continuation.resume(returning: .success(()))
					}
					return
				}
				continuation.resume(returning: .failure(LocationError.undefined))
			}
		}
	}
}
