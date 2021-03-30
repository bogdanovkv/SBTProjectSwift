//
//  LocationUseCaseTests.swift
//  SBTSwiftProjectTests
//
//  Created by Константин Богданов on 08.03.2021.
//  Copyright © 2021 Константин Богданов. All rights reserved.
//

@testable import SBTSwiftProject
import XCTest

extension CityModel: Equatable {
	public static func == (lhs: Self, rhs: Self) -> Bool {
		return lhs.codeIATA == rhs.codeIATA &&
			lhs.countryCode == rhs.countryCode &&
			lhs.name == rhs.name &&
			lhs.nameRu == rhs.nameRu
	}
}

extension CountryModel: Equatable {
	public static func == (lhs: Self, rhs: Self) -> Bool {
		return lhs.codeIATA == rhs.codeIATA &&
			lhs.name == rhs.name &&
			lhs.nameRu == rhs.nameRu
	}
}

final class LocationUseCaseTests: XCTestCase {

	var repositorySpy: LocationRepositorySpy_one!
	var sut: LocationUseCase!

    override func setUp() {
		super.setUp()
		repositorySpy = LocationRepositorySpy_one()
		sut = LocationUseCase(repository: repositorySpy)
	}

    override func tearDown() {
		repositorySpy = nil
		sut = nil
		super.tearDown()
	}

	func testGivenNameWhenGetCityThanReturnCityFromRepository() {
		// Setup
		let name = "name"
		let model = CityModel(codeIATA: "", countryCode: "", name: "", nameRu: "")

		repositorySpy.getCityWithNameStub = { cityName in
			if cityName == name{
				return model
			}
			return nil
		}

		// action
		let result = sut.getCity(named: name)

		// assert
		XCTAssertEqual(result, model)
	}

	func testGivenNameWhenGetCityThanReturnCityFrodjdsjmRepository() {
		let name = "somename"
		let countryModel = CountryModel(codeIATA: "123", name: "", nameRu: "")
		var isNameCorrect = false

		repositorySpy.getCountryWithNameStub = { countryName in
			isNameCorrect = countryName == name
			if isNameCorrect {
				return countryModel
			}
			return nil
		}

		let result = sut.getCountry(named: name)

		XCTAssert(isNameCorrect, "В параметр передано некорректное имя")
		XCTAssertEqual(result, countryModel)
	}
}

