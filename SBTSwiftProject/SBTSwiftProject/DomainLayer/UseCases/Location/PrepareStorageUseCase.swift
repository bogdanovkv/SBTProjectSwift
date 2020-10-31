//
//  PrepareStorageUseCase.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 24.10.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import Foundation

protocol PrepareStorageUseCaseProtocol {
	func prepareStorage(_ copmletion: @escaping (Result<Void, Error>) -> Void)
}

class PrepareStorageUseCase: PrepareStorageUseCaseProtocol {

	private let settingsRepository: UserSettingsRepositoryProtocol
	private let prepareAirportsUseCase: UseCase<Void, Void>
	private let prepareCountriesUseCase: UseCase<Void, Void>
	private let prepareCitiesUseCase: UseCase<Void, Void>
	private var citiesLoaded: Bool
	private var countriesLoaded: Bool
	private var airportsLoad: Bool

	init(settingsRepository: UserSettingsRepositoryProtocol,
		 prepareAirportsUseCase: UseCase<Void, Void>,
		 prepareCountriesUseCase: UseCase<Void, Void>,
		 prepareCitiesUseCase: UseCase<Void, Void>) {
		self.settingsRepository = settingsRepository
		self.prepareCitiesUseCase = prepareCitiesUseCase
		self.prepareCountriesUseCase = prepareCountriesUseCase
		self.prepareAirportsUseCase = prepareAirportsUseCase
		citiesLoaded = false
		countriesLoaded = false
		airportsLoad = false
	}

	func prepareStorage(_ copmletion: @escaping (Result<Void, Error>) -> Void) {
		guard !settingsRepository.didIntializeStorage else {
			return copmletion(.success(()))
		}

		let group = DispatchGroup()

		group.enter()
		group.enter()
		group.enter()

		prepareCitiesUseCase.execute(parameter: ()) { [weak self] result in
			if let _ = try? result.get() {
				self?.citiesLoaded = true
			}
			group.leave()
		}
		prepareAirportsUseCase.execute(parameter: ()) { [weak self] result in
				if let _ = try? result.get() {
					self?.airportsLoad = true
				}
			group.leave()
		}
		prepareCountriesUseCase.execute(parameter: ()) { [weak self] result in
				if let _ = try? result.get() {
					self?.countriesLoaded = true
			}
			group.leave()
		}

		group.notify(queue: .main, work: .init(block: { [weak self] in
			guard let self = self else {
				return copmletion(.failure(AppError.nilSelf))
			}
			if [self.airportsLoad, self.citiesLoaded, self.countriesLoaded].allSatisfy({ $0 }) {
				return copmletion(.success(()))
			}
			copmletion(.success(()))
		}))
	}
}
