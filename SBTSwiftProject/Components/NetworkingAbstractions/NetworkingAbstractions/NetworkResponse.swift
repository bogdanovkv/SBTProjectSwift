//
//  NetworkResponse.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 24.10.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//


/// Ответ от сервиса работы с сетью
public struct NetworkResponse<Response: Decodable> {

	/// Код HTTP
	public let httpCode: Int

	/// Модель данных
	public let data: Response?

	public init(httpCode: Int,
				data: Response?) {
		self.httpCode = httpCode
		self.data = data
	}
}
