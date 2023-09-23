//
//  CountriesRepositoryProtocol.swift
//  
//
//  Created by Константин Богданов on 30.04.2021.
//

import Foundation

/// Репозиторий работы с городами
public protocol CountriesRepositoryProtocol {
	/// Загружает список стран
	/// - Parameter completion: блок, выполняющийся при получении списка стран
	func loadCountries(_ completion: @escaping (Result<[CountryModel], Error>) -> Void)

	/// Сохраняет страны
	/// - Parameters:
	///   - countries: страны
	///   - completion: блок, выполняющийся по завершению сохранения
	func save(countries: [CountryModel], completion: @escaping () -> Void)

	/// Получает страну по имени
	/// - Parameter named: имя
	func getCountry(named: String) -> CountryModel?

	/// Получает страну по коду
	/// - Parameter named: код
	func getCountry(by codeIATA: String) -> CountryModel?

	/// Получает все страны
	func getCountries() -> [CountryModel]

	/// Очищает данные по странам
	func clearCountries()
}
