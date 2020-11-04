//
//  Throwable.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 01.11.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import UIKit

struct Throwable<Value: Decodable>: Decodable {

	let value: Value?

	init(from decoder: Decoder) throws {
		value = try? Value(from: decoder)
	}
}
