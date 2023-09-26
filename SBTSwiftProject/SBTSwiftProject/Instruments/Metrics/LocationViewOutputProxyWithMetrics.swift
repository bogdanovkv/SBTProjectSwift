//
//  LocationViewOutputProxyWithMetrics.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 26.09.2023.
//  Copyright © 2023 Константин Богданов. All rights reserved.
//

import OSLog

final class LocationViewOutputProxyWithMetrics: LocationViewOutput {

	private weak var output: LocationViewOutput?

	init(output: LocationViewOutput) {
		self.output = output
	}

	func repeatButtonTapped() {
		Logger.metrics.log("User tap repeat button.")
		output?.repeatButtonTapped()
	}

	func changeCityButtonTapped() {
		Logger.metrics.log("User tap change city button.")
		output?.changeCityButtonTapped()
	}

	func acceptButtonTapped() {
		Logger.metrics.log("User tap accept button.")
		output?.acceptButtonTapped()
	}

	func changeCountryButtonTapped() {
		Logger.metrics.log("User tap change country button.")
		output?.changeCountryButtonTapped()
	}
}
