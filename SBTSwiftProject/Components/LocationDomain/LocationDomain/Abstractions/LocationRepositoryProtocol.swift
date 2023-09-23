//
//  LocationRepositoryProtocol.swift
//
//  Created by Константин Богданов on 18.04.2021.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import Foundation

/// Репозиторий работы с локациями
public protocol LocationRepositoryProtocol {

	/// Получает место где находится пользователь
	/// - Parameter completion: блок, выполняющийся при получении локации
	func loadLocation(_ completion: @escaping (Result<LocationModel, Error>) -> Void)
}
