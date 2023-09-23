//
//  File.swift
//  
//
//  Created by Константин Богданов on 11.04.2021.
//

import CoreData
import DatabaseAbstraction

extension NSManagedObject: StoredObjectProtocol {
	public func setValue<Value>(_ value: Value?, forKey key: String) {
		let value: Any? = value as Any
		setValue(value, forKey: key)
	}

	public func value<Value>(forKey key: String) -> Value? {
		let object = value(forKey: key)
		return object as? Value
	}
}
