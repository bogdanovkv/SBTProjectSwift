//
//  PrepareStorageUseCase.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 24.10.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import Foundation

protocol PrepareStorageUseCaseProtocol {
	func prepareStorage(_ copmletion: @escaping (Result<Bool, Error>) -> Void)
}

class PrepareStorageUseCase: PrepareStorageUseCaseProtocol {

	private let locationRepository: LocationRepositoryProtocol
	private var citiesLoaded: Bool
	private var countriesLoaded: Bool

	init(locationRepository: LocationRepositoryProtocol) {
		self.locationRepository = locationRepository
		citiesLoaded = false
		countriesLoaded = false
	}

	func prepareStorage(_ copmletion: @escaping (Result<Bool, Error>) -> Void) {
		let group = DispatchGroup()

		group.enter()
		locationRepository.loadCities { [weak self] result in
			guard let self = self else {
				group.leave()
				return
			}
			if let cities = try? result.get() {
				self.citiesLoaded = true
				self.locationRepository.save(cities: cities) {
					group.leave()
				}
			} else {
				group.leave()
			}

			group.leave()
		}
		group.enter()

		locationRepository.loadCountries { [weak self] result in
			guard let self = self else {
				group.leave()
				return
			}
			if let countries = try? result.get() {
				self.countriesLoaded = true
				self.locationRepository.save(countries: countries) {
					group.leave()
				}
			} else {
				group.leave()
			}
		}

		group.notify(queue: .main, work: .init(block: {
			copmletion(.success(true))
		}))
	}
}
