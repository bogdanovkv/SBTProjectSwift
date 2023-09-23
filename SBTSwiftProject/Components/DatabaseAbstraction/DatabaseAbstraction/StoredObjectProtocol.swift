//
//  StoredObjectProtocol.swift
//  DatabaseAbstraction
//
//  Created by Константин Богданов on 05.04.2021.
//

/// Протокол объекта, хранимого в БД
public protocol StoredObjectProtocol {

	///  Устанавливает значение в объект
	/// - Parameters:
	///   - value: значение
	///   - key: ключ
	func setValue<Value>(_ value: Value?, forKey key: String)

	/// Получает значение по ключу
	/// - Parameter key: ключ
	func value<Value>(forKey key: String) -> Value?
}
