//
//  LocationAssembly.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 01.05.2021.
//  Copyright © 2021 Константин Богданов. All rights reserved.
//

import UIKit

final class LocationCoordinatorAssembly {

	func createCoordinator(locationModuleAssembly: LocationAssemblyProtocol,
						   router: RouterProtocol,
						   alertsAssembly: AlertControllerAssemblyProtocol,
						   selectCityCoordinatorAssembly: @escaping () -> Coordinator<String, Result<String, Error>>,
						   selectCountryCoordinatorAssembly: @escaping () -> Coordinator<Void, Result<String, Error>>,
						   tabBarCoordinatorAssembly: @escaping () -> Coordinator<(cityCode: String, countryCode: String), Void>) -> Coordinator<Void, Void> {

		let coordinator = LocationCoordinator(locationModuleAssembly: locationModuleAssembly,
											  router: router,
											  alertsAssembly: alertsAssembly,
											  selectCityCoordinatorAssembly: selectCityCoordinatorAssembly,
											  selectCountryCoordinatorAssembly: selectCountryCoordinatorAssembly,
											  tabBarCoordinatorAssembly: tabBarCoordinatorAssembly)
		return coordinator
	}

}
