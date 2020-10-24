//
//  ServiceLayerDependecies.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 24.10.2020.
//  Copyright © 2020 Константин Богданов. All rights reserved.
//

struct ServiceLayerDependecies {
	static func createNetworkService() -> NetworkServiceProtocol {
		return NetworkService(sesion: .shared)
	}
}
