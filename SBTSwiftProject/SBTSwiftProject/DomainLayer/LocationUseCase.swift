//
//  LocationUseCase.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 24.10.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import UIKit

protocol LocationUseCaseProtocol {
	func getLocation(_ completion: @escaping (Result<LocationModel, Error>) -> Void)
}

final class LocationUseCase: LocationUseCaseProtocol {
	private let repository: LocationRepositoryProtocol

	init(repository: LocationRepositoryProtocol) {
		self.repository = repository
	}
	
	func getLocation(_ completion: @escaping (Result<LocationModel, Error>) -> Void) {
		repository.loadLocation(completion)
	}

}
