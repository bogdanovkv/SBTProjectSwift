//
//  AppComposer.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 02.05.2021.
//  Copyright © 2021 Константин Богданов. All rights reserved.
//

import UIKit

final class AppComposer: Coordinator<Void, Void> {

	func createCoordinator(in rootController: UIViewController) -> Coordinator<Void, Void> {
		return Coordinator<Void, Void>()
	}

}
