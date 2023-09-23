//
//  NetworkServiceError.swift
//  
//
//  Created by Константин Богданов on 17.04.2021.
//

/// Ошибки сервиса работы с сетью
public enum NetworkServiceError: Error {
	/// Некорректный url
	case invalidUrl
	/// Нет данных
	case noData
	/// Ошибка парсинга
	case parsingError
	/// Неопределенная ошибка
	case undefined
}
