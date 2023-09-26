//
//  Logger+Categories.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 23.09.2023.
//  Copyright © 2023 Константин Богданов. All rights reserved.
//

import Foundation

import OSLog

extension Logger {

	private static let subsystem = "SBTSwiftProject"

	static let network = Logger(subsystem: subsystem, category: "network")

	static let metrics = Logger(subsystem: subsystem, category: "navigation")
}
