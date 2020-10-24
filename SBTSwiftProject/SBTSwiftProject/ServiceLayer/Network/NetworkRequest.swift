//
//  NetworkRequest.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 24.10.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import Foundation

/// HTTP метод
enum HTTPMethod: String {
	case GET
	case POST
}

/// Модель запроса в сеть
struct NetworkRequest {
	struct Parameter {
		let key: String
		let value: String
	}
	let url: URL
	let methon: HTTPMethod
	let parameters: [Parameter]
}
