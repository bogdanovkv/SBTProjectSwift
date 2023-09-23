//
//  UserSettingsRepositoryProtocol.swift
//  LocationDomain
//
//  Created by Константин Богданов on 23.09.2023.
//

/// Репозиторий настроек пользователя
public protocol UserSettingsRepositoryProtocol {

	/// Было ли проинициализировано хранилище (страны, города, аэропорты)
	var didIntializeStorage: Bool { get set }
}
