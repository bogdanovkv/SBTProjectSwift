//
//  UseCase.swift
//  DomainAbstractions
//
//  Created by Константин Богданов on 21.09.2023.
//

public protocol UseCase<Input, Result> {
	associatedtype Input
	associatedtype Result

	func execute(input: Input) -> Result
}

public protocol UseCaseAsync<Input, Result> {
	associatedtype Input
	associatedtype Result

	func execute(input: Input) async -> Result
}
