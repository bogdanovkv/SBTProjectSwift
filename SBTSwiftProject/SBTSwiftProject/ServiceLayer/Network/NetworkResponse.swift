//
//  NetworkResponse.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 24.10.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import Foundation

/// Ответ от сервиса работы с сетью
struct NetworkResponse<Response: Decodable> {

	/// Код HTTP
	let httpCode: Int

	/// Модель данных
	let data: Response?
}
