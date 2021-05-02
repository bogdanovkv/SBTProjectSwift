//
//  AppDelegate.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 14.07.2018.
//  Copyright © 2018 Константин Богданов. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
	var appCoordinator: Coordinator<Void, Void>?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
		let rootController = UINavigationController()
		let appComposer = AppComposer()

		let coordinator = appComposer.composeCoordinator(in: rootController)
		self.appCoordinator = coordinator

		if let currentWindow = window {
			currentWindow.rootViewController = rootController
            currentWindow.makeKeyAndVisible()
        }

		appCoordinator?.start()

        return true
    }
}
