//
//  LocationUseCase.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 24.10.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import Inject

protocol LocationUseCaseProtocol {
	func getLocation(_ completion: @escaping (Result<LocationModel, Error>) -> Void)
	func getCity(named: String) -> CityModel?
	func getCountry(named: String) -> CountryModel?
}

final class LocationUseCase: LocationUseCaseProtocol {
	private let repository: LocationRepositoryProtocol

	init(repository: LocationRepositoryProtocol) {
		self.repository = repository
	}

	convenience init() {
		let factory = Inject<DataLayerDependencies>.dataLayer
		let repository = factory.create(closure: { $0.createLocationRepository() },
										strategy: .scope(key: 0))
		self.init(repository: repository)
	}

	func getLocation(_ completion: @escaping (Result<LocationModel, Error>) -> Void) {
		repository.loadLocation(completion)
	}

	func getCity(named: String) -> CityModel? {
		return repository.getCity(with: named)
	}

	func getCountry(named: String) -> CountryModel? {
		return repository.getCountry(with: named)
	}
}
