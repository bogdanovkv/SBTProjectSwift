//
//  DatabaseServiceProtocol.swift
//  DatabaseAbstraction
//
//  Created by Константин Богданов on 05.04.2021.
//

/// Протокол сервиса общающегося с БД
public protocol DatabaseServiceProtocol {

	/// Извлекает модели из БД
	/// - Parameters:
	///   - storeId: идентификатор для хранения
	///   - convertClosure: блок для преобразования БД модели в обычную
	func fetch<Model>(storeId: String,
					  convertClosure: (StoredObjectProtocol) -> Model?) -> [Model]

	/// Извлекает модели из БД
	/// - Parameters:
	///   - storeId: идентификатор для хранения
	///   - convertClosure: блок для преобразования БД модели в обычную
	///   - predicate: предикат для выборки моделей
	func fetch<Model>(storeId: String,
					  convertClosure: (StoredObjectProtocol) -> Model?,
													predicate: [String: String]) -> [Model]

	/// Добавить модели в БД
	/// - Parameters:
	///   - storeId: идентификатор хранимой модели
	///   - models: модели
	///   - convertClosure: блок, в котором происходит установка свойст БД модели
	///   - completion: блок, выполняющийся по завершению сохранения моделей
	func insert<Model>(storeId: String,
					   models: [Model],
					   convertClosure: @escaping (Model, StoredObjectProtocol) -> Void,
					   completion: @escaping () -> Void)

	/// Удаляет все модели из БД
	/// - Parameters:
	///   - storeId: идентификатор моделей
	///   - completion: блок, выполняющийся по завершению удаления моделей
	func deleteAll(storeId: String, completion: @escaping () -> Void)
}
