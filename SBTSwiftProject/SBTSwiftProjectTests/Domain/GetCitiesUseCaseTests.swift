//
//  GetCitiesUseCaseTests.swift
//  SBTSwiftProjectTests
//
//  Created by Константин Богданов on 21.02.2021.
//  Copyright © 2021 Константин Богданов. All rights reserved.
//

@testable import SBTSwiftProject
import XCTest

class GetCitiesUseCaseTests: XCTestCase {
	var useCase: GetCitiesUseCase!
	var repositorySpy: LocationRepositorySpy!
    override func setUp() {
		super.setUp()
		repositorySpy = LocationRepositorySpy()
		useCase = GetCitiesUseCase(repository: repositorySpy)
    }

    override func tearDown() {
		repositorySpy = nil
		useCase = nil
		super.tearDown()
	}

	func testWhenExecuteCaseThanCallRepository() {

		_ = useCase.execute(parameter: .init(codeIATA: "", name: "", nameRu: ""))

		XCTAssert(repositorySpy.getCitiesWasCalled)
	}
}
