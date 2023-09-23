//
//  CitiesRepositoryProtocol.swift
//  
//
//  Created by Константин Богданов on 30.04.2021.
//

import Foundation

/// Репозиторий работы с городами
public protocol CitiesRepositoryProtocol {

	/// Загружает список городов
	/// - Parameter completion: блок, выполняющийся при получении списка городов
	func loadCities(_ completion: @escaping (Result<[CityModel], Error>) -> Void)

	/// Сохраняет города
	/// - Parameters:
	///   - countries: города
	///   - completion: блок, выполняющийся по завершению сохранения
	func save(cities: [CityModel], completion: @escaping () -> Void)

	/// Получает все для страны
	/// - Parameter countryCode: код страны
	func getCities(for countryCode: String) -> [CityModel]

	/// Получает город по имени
	/// - Parameter named: имя
	func getCity(named: String) -> CityModel?

	/// Получает город по коду
	/// - Parameter codeIATA: код города
	func getCity(by codeIATA: String) -> CityModel?

	/// Очищает данные по городам
	func clearCities()
}
