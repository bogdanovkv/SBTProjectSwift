//
//  TicketsSearchInteractorOutputMainThreadProxy.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 23.09.2023.
//  Copyright © 2023 Константин Богданов. All rights reserved.
//

import Foundation
import TicketsDomain

final class TicketsSearchInteractorOutputMainThreadProxy: TicketsSearchInteractorOutput {

	private weak var output: TicketsSearchInteractorOutput?

	init(output: TicketsSearchInteractorOutput?) {
		self.output = output
	}

	func didRecieve(tickets: [TicketsDomain.Ticket]) {
		Task { @MainActor () -> Void in
			output?.didRecieve(tickets: tickets)
		}
	}

	func didRecieve(error: Error) {
		Task { @MainActor () -> Void in
			output?.didRecieve(error: error)
		}
	}
}
