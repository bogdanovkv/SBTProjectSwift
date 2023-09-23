//
//  PrepareStorageUseCase.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 24.10.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import DomainAbstractions
import LocationDomainModels

final class PrepareStorageUseCase: UseCaseAsync {

	// TODO: - make public
	enum CaseError: Error {
		case locationError
	}

	private var settingsRepository: UserSettingsRepositoryProtocol
	private let prepareAirportsUseCase: any UseCaseAsync<Void, Swift.Result<Void, Error>>
	private let prepareCountriesUseCase: any UseCaseAsync<Void, Swift.Result<Void, Error>>
	private let prepareCitiesUseCase: any UseCaseAsync<Void, Swift.Result<Void, Error>>
	private let clearStorageUseCase: any UseCase<Void, Void>

	init(settingsRepository: UserSettingsRepositoryProtocol,
		 prepareAirportsUseCase: any UseCaseAsync<Void, Swift.Result<Void, Error>>,
		 prepareCountriesUseCase: any UseCaseAsync<Void, Swift.Result<Void, Error>>,
		 prepareCitiesUseCase: any UseCaseAsync<Void, Swift.Result<Void, Error>>,
		 clearStorageUseCase: any UseCase<Void, Void>) {
		self.settingsRepository = settingsRepository
		self.clearStorageUseCase = clearStorageUseCase
		self.prepareCitiesUseCase = prepareCitiesUseCase
		self.prepareCountriesUseCase = prepareCountriesUseCase
		self.prepareAirportsUseCase = prepareAirportsUseCase
	}

	func execute(input: Void) async -> Result<Void, Error> {
		guard !settingsRepository.didIntializeStorage else {
			return .success(())
		}
		clearStorageUseCase.execute(input: ())

		return await withTaskGroup(of: Swift.Result<Void, Error>.self) { group in
			group.addTask {
				await self.prepareCitiesUseCase.execute(input: ())
			}
			group.addTask {
				await self.prepareAirportsUseCase.execute(input: ())
			}
			group.addTask {
				await self.prepareCountriesUseCase.execute(input: ())
			}
			for await result in group {
				guard (try? result.get()) != nil else {
					group.cancelAll()
					return .failure(CaseError.locationError)
				}
			}
			return .success(())
		}
	}
}
