//
//  TicketsRepository+TicketsRepositoryProtocol.swift
//  SBTSwiftProject
//
//  Created by Константин Богданов on 23.09.2023.
//  Copyright © 2023 Константин Богданов. All rights reserved.
//

import TicketsDomain
import TicketsRepository

extension TicketsRepository: TicketsRepositoryProtocol {
	public func loadTickets(fromCityCodeIATA: String, fromDate: Date?, toCityCodeIATA: String, returnDate: Date?) async throws -> [TicketsDomain.TicketModel] {
		return try await withCheckedThrowingContinuation { continuation in
			loadTickets(fromCityCodeIATA: fromCityCodeIATA,
						fromDate: fromDate,
						toCityCodeIATA: toCityCodeIATA,
						returnDate: returnDate) { result in
				continuation.resume(with: result)
			}
		}
	}
}
