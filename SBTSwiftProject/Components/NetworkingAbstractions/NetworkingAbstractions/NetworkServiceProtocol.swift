//
//  NetworkServiceProtocol.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 24.10.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

/// Сервис работы с сетью
public protocol NetworkServiceProtocol {

	/// Выполняет запрос (хранит полученные данные in memory)
	/// - Parameters:
	///   - request: запрос
	///   - completion: сблок выполняющийся с результатом запроса
	func perfom<Model: Decodable>(request: NetworkRequest,
								  _ completion: @escaping (Result<NetworkResponse<Model>, Error>) -> Void)

	/// Загружает данные по запросу (хранит данные на диске)
	/// - Parameters:
	///   - request: запрос
	///   - completion: блок, выполняющийся  с результатом запроса
	func download(request: NetworkRequest,
				  _ completion: @escaping (Result<URL, Error>) -> Void)
}
