//
//  LocationInteractorOutputMainThreadProxy.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 23.09.2023.
//  Copyright © 2023 Константин Богданов. All rights reserved.
//

import Foundation
import LocationDomainModels

final class LocationInteractorOutputMainThreadProxy: LocationInteractorOutput {

	private weak var output: LocationInteractorOutput?

	init(output: LocationInteractorOutput) {
		self.output = output
	}

	func didRecieveLocationError() {
		Task { @MainActor () -> Void in
			output?.didRecieveLocationError()
		}
	}
	
	func didPrepareStorage() {
		Task { @MainActor () -> Void in
			output?.didPrepareStorage()
		}
	}
	
	func didRecievePrepareStorageError() {
		Task { @MainActor () -> Void in
			output?.didRecievePrepareStorageError()
		}
	}
	
	func didRecieve(city: LocationDomainModels.City) {
		Task { @MainActor () -> Void in
			output?.didRecieve(city: city)
		}
	}
	
	func didRecieve(country: LocationDomainModels.Country) {
		Task { @MainActor () -> Void in
			output?.didRecieve(country: country)
		}
	}
}
