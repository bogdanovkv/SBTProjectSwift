//
//  NetworkResponse.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 24.10.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

import Foundation

struct NetworkResponse<Response: Decodable> {
	let httpCode: Int
	let data: Response?
}
