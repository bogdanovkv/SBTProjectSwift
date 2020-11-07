//
//  Date.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 04.11.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import UIKit

/// Расширение Date
extension Date {

	/// Конвертирует даты в строку в формате dd-MM-yyyy
	/// - Returns: строка с датой
	func format_DD_MM_YYYY() -> String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "dd-MM-yyyy"
		return dateFormatter.string(from: self)
	}
}
