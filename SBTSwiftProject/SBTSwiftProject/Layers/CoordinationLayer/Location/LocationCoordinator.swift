//
//  LocationCoordinator.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 01.05.2021.
//  Copyright © 2021 Константин Богданов. All rights reserved.
//

import UIKit

/// Координатор экрана получения местоположения
final class LocationCoordinator: Coordinator<Void, Void> {

	private let locationModuleAssembly: LocationAssemblyProtocol
	private let router: RouterProtocol
	private let alertsAssembly: AlertControllerAssemblyProtocol
	private let selectCityCoordinatorAssembly: () -> Coordinator<String, Result<String, Error>>
	private let selectCountryCoordinatorAssembly: () -> Coordinator<Void, Result<String, Error>>
	private let tabBarCoordinatorAssembly: () -> Coordinator<(cityCode: String, countryCode: String), Void>

	private var locationModule: LocationModuleInput?
	private var selectCityCoordinator: Coordinator<String, Result<String, Error>>?
	private var selectCountryCoordinator: Coordinator<Void, Result<String, Error>>?
	private var tabBarCoordinator: Coordinator<(cityCode: String, countryCode: String), Void>?

	init(locationModuleAssembly: LocationAssemblyProtocol,
		 router: RouterProtocol,
		 alertsAssembly: AlertControllerAssemblyProtocol,
		 selectCityCoordinatorAssembly: @escaping () -> Coordinator<String, Result<String, Error>>,
		 selectCountryCoordinatorAssembly: @escaping () -> Coordinator<Void, Result<String, Error>>,
		 tabBarCoordinatorAssembly: @escaping () -> Coordinator<(cityCode: String, countryCode: String), Void>) {
		self.locationModuleAssembly = locationModuleAssembly
		self.alertsAssembly = alertsAssembly
		self.selectCityCoordinatorAssembly = selectCityCoordinatorAssembly
		self.selectCountryCoordinatorAssembly = selectCountryCoordinatorAssembly
		self.tabBarCoordinatorAssembly = tabBarCoordinatorAssembly
		self.router = router
	}

	override func start(parameter: Void) {
		var locationModule = locationModuleAssembly.createController()
		locationModule.moduleOutput = self
		self.locationModule = locationModule
		router.push(locationModule, animated: false)
	}
}

extension LocationCoordinator: LocationModuleOutput {

	func moduleDidRecievePrepareStorageError() {
		let action = UIAlertAction(title: "Повторить", style: .default, handler: { [weak self] _ in
			self?.router.dismiss({
				self?.locationModule?.retryPrepareStorage()
			})
		})
		let alert = alertsAssembly.createController(title: "Не удалось получить данные :(",
													message: "Не удалось загрузить данные по странам, городам и аэропортам. Попробуйте повторить попытку позже.",
													preferredStyle: .alert,
													actions: [action])
		router.present(alert)
	}

	func moduleDidRecieveLocationError() {
		let manualAction = UIAlertAction(title: "Выбрать вручную", style: .cancel, handler: { [weak self] _ in
			self?.router.dismiss(nil)
		})
		let repeatAction = UIAlertAction(title: "Повторить", style: .default, handler: { [weak self] _ in
			self?.router.dismiss({ [weak self] in
				self?.locationModule?.retryGetLoaction()
			})
		})
		let alert = alertsAssembly.createController(title: "Не удалось получить данные :(",
													message: "Не удалось получить ваше местоположение, повторите попытку или выберите его самостоятельно.",
													preferredStyle: .alert,
													actions: [manualAction, repeatAction])
		router.present(alert)
	}

	func userSelectChangeCountry() {
		let coordinator = selectCountryCoordinatorAssembly()
		self.selectCountryCoordinator = coordinator
		coordinator.finishFlow = { [weak self] result in
			self?.selectCityCoordinator = nil
			switch result {
			case .success(let countryCode):
				self?.locationModule?.didUpdateCountry(with: countryCode)
			case .failure:
				// TODO: Обработка ошибки
			break
			}
		}
		coordinator.start()
	}

	func userSelectChangeCity(for countryCode: String) {
		let coordinator = selectCityCoordinatorAssembly()
		self.selectCityCoordinator = coordinator
		coordinator.finishFlow = { [weak self] result in
			self?.selectCityCoordinator = nil
			switch result {
			case .success(let cityCode):
				self?.locationModule?.didUpdateCity(with: cityCode)
			case .failure:
				// TODO: Обработка ошибки
			break
			}
		}
		coordinator.start(parameter: countryCode)
	}

	func userSelectLocation(with cityCode: String, countryCode: String) {
		let coordinator = tabBarCoordinatorAssembly()
		self.tabBarCoordinator = coordinator
		coordinator.finishFlow = { [weak self] _ in
			self?.tabBarCoordinator = nil
		}
		tabBarCoordinator?.start(parameter: (cityCode, countryCode))
	}
}
