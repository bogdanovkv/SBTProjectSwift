//
//  UseCase.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 31.10.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import UIKit

class UseCase<Parameter, Response> {

	func execute(parameter: Parameter,
				 _ completion: @escaping (Result<Response, Error>) -> Void) {
		fatalError("execute(parameter: completion:) is not implemented")
	}
}
