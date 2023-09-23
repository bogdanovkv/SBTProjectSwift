//
//  LocationUseCase.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 24.10.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import LocationDomainModels
import DomainAbstractions

/// Кейс получения местополжения
final class LocationUseCase: UseCaseAsync {
	private let repository: LocationRepositoryProtocol

	/// Инициализатор
	/// - Parameter repository: реозиторий
	init(repository: LocationRepositoryProtocol) {
		self.repository = repository
	}

	func execute(input: Void) async -> Result<Location, Error> {
		return await withCheckedContinuation { continuation in
			repository.loadLocation { result in
				do {
					let locationModel = try result.get()
					continuation.resume(returning: .success(locationModel.locationValue()))
				} catch {
					continuation.resume(returning: .failure(error))
				}
			}
		}
	}
}
