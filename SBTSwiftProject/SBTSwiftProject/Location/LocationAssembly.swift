//
//  LocationAssembly.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 24.10.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import UIKit

struct LocationAssembly {

	func createController() -> UIViewController {
		let interactor = LocationInteractor(getLocationUseCase: DomainLayerDependencies.createLocationUseCase())
		let locationController = LocationViewController(interactor: interactor)
		interactor.ouptput = locationController
		return locationController
	}
}
