//
//  AlertControllerAssembly.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 02.11.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import UIKit

/// Сборщик системных алертов
protocol AlertControllerAssemblyProtocol {

	/// Создает алерт контроллер
	/// - Parameters:
	///   - title: заголовок
	///   - message: сообщение
	///   - preferredStyle: стиль
	///   - actions: действия
	func createController(title: String?,
						  message: String?,
						  preferredStyle: UIAlertController.Style,
						  actions: [UIAlertAction]) -> UIAlertController
}

final class AlertControllerAssembly: AlertControllerAssemblyProtocol {

	func createController(title: String?,
						  message: String?,
						  preferredStyle: UIAlertController.Style,
						  actions: [UIAlertAction]) -> UIAlertController {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: preferredStyle)
		actions.forEach({ alertController.addAction($0) })
        return alertController
    }

}
