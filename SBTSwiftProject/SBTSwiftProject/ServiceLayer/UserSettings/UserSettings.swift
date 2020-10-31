//
//  UserSettings.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 26.10.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import Foundation

protocol UserSettingsProtocol {
	func set(value: Any, for key: String)
	func getValue(for key: String) -> Any?
}

final class UserSettings: UserSettingsProtocol {

	private let userDefaults: UserDefaults

	init(userDefaults: UserDefaults) {
		self.userDefaults = userDefaults
	}

	func set(value: Any, for key: String) {
		userDefaults.set(value, forKey: key)
	}

	func getValue(for key: String) -> Any? {
		return userDefaults.value(forKey: key)
	}
}
