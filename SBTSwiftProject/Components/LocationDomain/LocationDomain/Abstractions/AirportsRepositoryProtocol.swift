//
//  AirportsRepositoryProtocol.swift
//  
//
//  Created by Константин Богданов on 30.04.2021.
//

import Foundation

/// Репозиторий работы с аэропортами
public protocol AirportsRepositoryProtocol {

	/// Загружает список аэропортов
	/// - Parameter completion: блок, выполняющийся при получении списка стран
	func loadAirports(_ completion: @escaping (Result<[AirportModel], Error>) -> Void)

	/// Сохраняет аэропорты
	/// - Parameters:
	///   - countries: аэропорты
	///   - completion: блок, выполняющийся по завершению сохранения
	func save(airports: [AirportModel], completion: @escaping () -> Void)

	/// Получает все аэропорты
	func getAirports() -> [AirportModel]

	/// Получает аэропорт по коду
	/// - Parameter code: код
	func getAirport(by code: String) -> AirportModel?

	/// Получает все аэропорты для города
	/// - Parameter codeIATA: код корода
	func getAirportForCity(with codeIATA: String) -> [AirportModel]

	/// Получает все аэропорты для страны
	/// - Parameter codeIATA: код страны
	func getAirportForCountry(with codeIATA: String) -> [AirportModel]

	/// Удаляет данные по аэропортам
	func clearAipotrs()
}
