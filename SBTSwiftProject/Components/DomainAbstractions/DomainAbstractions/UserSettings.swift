//
//  UserSettings.swift
//  DomainAbstractions
//
//  Created by Константин Богданов on 23.09.2023.
//

import Foundation

/// Репозиторий настроек пользователя
public protocol UserSettings {

	/// Было ли проинициализировано хранилище (страны, города, аэропорты)
	var didIntializeStorage: Bool { get set }
}

