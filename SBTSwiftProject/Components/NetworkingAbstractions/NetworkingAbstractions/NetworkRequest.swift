//
//  NetworkRequest.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 24.10.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

/// HTTP метод
public enum HTTPMethod: String {
	case GET
	case POST
}

/// Модель запроса в сеть
public struct NetworkRequest {

	/// Параметр запроса
	public struct Parameter {

		/// Ключ
		public let key: String

		/// Значение
		public let value: String

		/// Инициализатор
		/// - Parameters:
		///   - key: ключ
		///   - value: значение
		public init(key: String,
					value: String) {
			self.key = key
			self.value = value
		}
	}

	/// URL
	public let url: String

	/// HTTP метод
	public let method: HTTPMethod

	/// Параметры
	public let parameters: [Parameter]

	public init(url: String,
				method: HTTPMethod,
				parameters: [Parameter]) {
		self.url = url
		self.method = method
		self.parameters = parameters
	}
}
