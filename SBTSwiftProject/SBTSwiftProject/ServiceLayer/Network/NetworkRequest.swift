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

	/// Параметр запроса
	struct Parameter {

		/// Ключ
		let key: String

		/// Значение
		let value: String
	}

	/// URL
	let url: URL

	/// HTTP метод
	let methon: HTTPMethod

	/// Параметры
	let parameters: [Parameter]
}
