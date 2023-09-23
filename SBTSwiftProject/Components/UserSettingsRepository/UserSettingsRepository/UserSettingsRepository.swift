//
//  UserSettingsRepository.swift
//  UserSettingsRepository
//
//  Created by Константин Богданов on 23.09.2023.
//

import LocationDomain

/// Протокол  сервиса для хранения пользовательских настроек
public protocol UserSettingsServiceProtocol {

	/// Сохраняет значение по ключу
	/// - Parameters:
	///   - value: значение
	///   - key: ключ
	func set(value: Any, for key: String)

	/// Получает значение по ключу
	/// - Parameter key: ключ
	/// - Returns: значение
	func getValue(for key: String) -> Any?
}


/// Репозиторий настроек пользователя
public final class UserSettingsRepository: UserSettingsRepositoryProtocol {
	private let userSettings: UserSettingsServiceProtocol

	private enum Settings: String {
		case didInitializeStorage
	}

	public init(userSettings: UserSettingsServiceProtocol) {
		self.userSettings = userSettings
	}

	public var didIntializeStorage: Bool {
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
