//
//  UserSettingsSerivce.swift
//  UserSettingsService
//
//  Created by Константин Богданов on 23.09.2023.
//

import UserSettingsRepository

/// Сервис по хранению настроек пользователя
public final class UserSettingsService: UserSettingsServiceProtocol {

	private let userDefaults: UserDefaults

	/// Инициализатор
	/// - Parameter userDefaults: UserDefaults
	public init(userDefaults: UserDefaults) {
		self.userDefaults = userDefaults
	}

	public func set(value: Any, for key: String) {
		userDefaults.set(value, forKey: key)
	}

	public func getValue(for key: String) -> Any? {
		return userDefaults.value(forKey: key)
	}
}
