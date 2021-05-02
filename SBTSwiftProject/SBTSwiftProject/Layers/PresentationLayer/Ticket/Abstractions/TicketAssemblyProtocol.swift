//
//  TiketAssemblyProtocol.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 01.05.2021.
//  Copyright © 2021 Константин Богданов. All rights reserved.
//

import UIKit

/// Сборщик экрана отобраения билета
protocol TicketAssemblyProtocol {
	func createViewCotroller(for tiket: TicketPresentationModel) -> UIViewController & TicketModuleInput
}
