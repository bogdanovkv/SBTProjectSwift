//
//  PrepareCitiesUseCase.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 31.10.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

final class PrepareCitiesUseCase: UseCase<Void, Void> {

	private let locationRepository: LocationRepositoryProtocol

	init(locationRepository: LocationRepositoryProtocol) {
		self.locationRepository = locationRepository
	}

	override func execute(parameter: Void, _ completion: @escaping (Result<Void, Error>) -> Void) {
		locationRepository.loadCities { [weak self] result in
			guard let self = self else {
				return completion(.failure(AppError.nilSelf))
			}
			if let cities = try? result.get() {
				self.locationRepository.save(cities: cities) {
					completion(.success(()))
				}
				return
			}
			completion(.failure(AppError.serviceError))
		}
	}
}
