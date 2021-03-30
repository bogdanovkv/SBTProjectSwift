//
//  LocationRepositorySpy.swift
//  SBTSwiftProjectTests
//
//  Created by Константин Богданов on 21.02.2021.
//  Copyright © 2021 Константин Богданов. All rights reserved.
//

@testable import SBTSwiftProject

class LocationRepositorySpy: LocationRepositoryProtocol {
	var getCitiesWasCalled = false

	func loadLocation(_ completion: @escaping (Result<LocationModel, Error>) -> Void) {
	}

	func loadCities(_ completion: @escaping (Result<[CityModel], Error>) -> Void) {
	}

	func loadCountries(_ completion: @escaping (Result<[CountryModel], Error>) -> Void) {
	}

	func loadAirports(_ completion: @escaping (Result<[AirportModel], Error>) -> Void) {
	}

	func save(countries: [CountryModel], completion: @escaping () -> Void) {
	}

	func save(cities: [CityModel], completion: @escaping () -> Void) {

	}

	func save(airports: [AirportModel], completion: @escaping () -> Void) {

	}

	func getCity(with name: String) -> CityModel? {
		return nil
	}

	func getCountry(with name: String) -> CountryModel? {
		return nil
	}

	func clearLocations() {

	}

	func getCountries() -> [CountryModel] {
		return []
	}


	func getCities(for country: CountryModel) -> [CityModel] {
		getCitiesWasCalled = true
		return []
	}

	func getAirports() -> [AirportModel] {
		return []
	}


}
