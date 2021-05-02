//
//  AppComposer.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 02.05.2021.
//  Copyright © 2021 Константин Богданов. All rights reserved.
//

import UIKit

/// Сборщик главного координатора приложени
final class AppComposer {

	/// Создает координатор
	/// - Parameter rootController: корневой контроллер
	/// - Returns: координатор
	func composeCoordinator(in rootController: UINavigationController) -> Coordinator<Void, Void> {
		let serviceLayerComposer = ServiceLayerComposer()
		let dataLayerComposer = DataLayerComposer(serviceLayerComposer: serviceLayerComposer)
		let domainLayerComposer = DomainLayerComposer(dataLayerComposer: dataLayerComposer)
		let presentationLayerComposer = PresentationLayerComposer(domainLayerComposer: domainLayerComposer)
		let coordinationLayerComposer = CoordinationLayerComposer(presentationComposer: presentationLayerComposer,
																  rootController: rootController)
		return coordinationLayerComposer.composeLocationCoordinator()
	}
}
