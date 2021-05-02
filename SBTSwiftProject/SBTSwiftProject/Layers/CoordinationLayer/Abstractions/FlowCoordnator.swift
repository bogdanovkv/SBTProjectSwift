//
//  FlowCoordnator.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 29.04.2021.
//  Copyright © 2021 Константин Богданов. All rights reserved.
//

import UIKit

protocol FlowCoordnator {
	associatedtype InputParameter
	associatedtype FlowResult

	var finishFlow: ((FlowResult) -> Void)? { get set }

	func start(parameter: InputParameter)
}

class Coordinator<Input, Result>: FlowCoordnator {

	typealias InputParameter = Input
	typealias FlowResult = Result

	var finishFlow: ((FlowResult) -> Void)?

	func start(parameter: Input) {
		assert(false, "Should be overrided by subclass")
	}
}

extension FlowCoordnator where InputParameter == Void {
	func start() {
		start(parameter: ())
	}
}
