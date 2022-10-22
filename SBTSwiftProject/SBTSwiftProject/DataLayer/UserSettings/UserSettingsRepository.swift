//
//  UserSettingsRepository.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 26.10.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

/// Репозиторий настроек пользователя
protocol UserSettingsRepositoryProtocol: AnyObject {

	/// Было ли проинициализировано хранилище (страны, города, аэропорты)
	var didIntializeStorage: Bool { get set }
}

/// Репозиторий настроек пользователя
final class UserSettingsRepository: UserSettingsRepositoryProtocol {
	private let userSettings: UserSettingsProtocol

	private enum Settings: String {
		case didInitializeStorage
	}

	init(userSettings: UserSettingsProtocol) {
		self.userSettings = userSettings
	}

	var didIntializeStorage: Bool {
		get {
			return get(setting: .didInitializeStorage) as? Bool ?? false
		} set {
			set(setting: .didInitializeStorage, value: newValue)
		}
	}

	private func get(setting: Settings) -> Any? {
		return userSettings.getValue(for: setting.rawValue)
	}

	private func set(setting: Settings, value: Any) {
		userSettings.set(value: value, for: setting.rawValue)
	}
}
