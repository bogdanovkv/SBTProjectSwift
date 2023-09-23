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

	/// Logs the view cycles like a view that appeared.
	static let network = Logger(subsystem: subsystem, category: "network")

	/// All logs related to tracking and analytics.
	static let statistics = Logger(subsystem: subsystem, category: "navigation")
}
