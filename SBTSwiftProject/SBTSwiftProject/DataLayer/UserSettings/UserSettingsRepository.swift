//
//  UserSettingsRepository.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 26.10.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import Inject

/// Репозиторий настроек пользователя
protocol UserSettingsRepositoryProtocol {

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

	convenience init() {
		let settings = Inject<ServiceLayerDependecies>.serviceLayer.create(closure: { $0.createUserSettings() },
												  strategy: .scope(key: 0))
		self.init(userSettings: settings)
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
