//
//  FlowCoordnator.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 29.04.2021.
//  Copyright © 2021 Константин Богданов. All rights reserved.
//

import UIKit

protocol FlowCoordnator {
	associatedtype FlowResult

	var finishFlow: ((FlowResult) -> Void)? { get set }

	func start()
}

class Coordinator<FlowResult>: FlowCoordnator {
	var finishFlow: ((FlowResult) -> Void)?

	func start() {
		assert(false, "Should be overrided by subclass")
	}
}
