//
//  Router.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 01.05.2021.
//  Copyright © 2021 Константин Богданов. All rights reserved.
//

import UIKit

protocol RouterProtocol {

	func push(_ viewController: UIViewController)

	func push(_ viewController: UIViewController, animated: Bool)

	func pop(animated: Bool)

	func popToRoot(animated: Bool)

	func present(_ viewController: UIViewController)

	func present(_ viewController: UIViewController, animated: Bool)

	func dismiss(_ completion: (() -> Void)?)
}

final class Router: RouterProtocol {

	private weak var navigationController: UINavigationController?

	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}

	func pop(animated: Bool) {
		navigationController?.popViewController(animated: animated)
	}

	func push(_ viewController: UIViewController) {
		navigationController?.pushViewController(viewController, animated: true)
	}

	func push(_ viewController: UIViewController, animated: Bool) {
		navigationController?.pushViewController(viewController, animated: animated)
	}

	func popToRoot(animated: Bool) {
		navigationController?.popToRootViewController(animated: animated)
	}

	func present(_ viewController: UIViewController) {
		navigationController?.present(viewController, animated: true, completion: nil)
	}

	func present(_ viewController: UIViewController, animated: Bool) {
		navigationController?.present(viewController, animated: animated, completion: nil)
	}

	func dismiss(_ completion: (() -> Void)?) {
		navigationController?.presentedViewController?.dismiss(animated: true, completion: completion)
	}
}
