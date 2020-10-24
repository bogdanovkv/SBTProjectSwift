//
//  LocationInteractor.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 24.10.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import Foundation

protocol LocationInteractorInput: AnyObject {
	func getLocation()
}

protocol LocationInteractorOutput: AnyObject {
	func didUpdateLocation(_ location: LocationModel)
	func didRecieveError()
}

final class LocationInteractor: LocationInteractorInput {

	weak var ouptput: LocationInteractorOutput?

	private let getLocationUseCase: LocationUseCaseProtocol

	init(getLocationUseCase: LocationUseCaseProtocol) {
		self.getLocationUseCase = getLocationUseCase
	}

	func getLocation() {
		getLocationUseCase.getLocation { [weak self] result in
			DispatchQueue.main.async {
				guard let location = try? result.get() else {
							self?.ouptput?.didRecieveError()
							return
				}
				self?.ouptput?.didUpdateLocation(location)
			}
		}
	}
}
