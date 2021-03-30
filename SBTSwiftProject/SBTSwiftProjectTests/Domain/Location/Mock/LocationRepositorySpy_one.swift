//
//  LocationRepositorySpy.swift
//  SBTSwiftProjectTests
//
//  Created by Константин Богданов on 08.03.2021.
//  Copyright © 2021 Константин Богданов. All rights reserved.
//

@testable import SBTSwiftProject

final class LocationRepositorySpy_one: LocationRepositoryProtocol {

	var getCityWithNameStub: ((String) -> CityModel?)?
	var getCountryWithNameStub: ((String) -> CountryModel?)?

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
		return getCityWithNameStub?(name)
	}

	func getCountry(with name: String) -> CountryModel? {
		return getCountryWithNameStub?(name)
	}

	func clearLocations() {

	}

	func getCountries() -> [CountryModel] {
		return []
	}

	func getCities(for country: CountryModel) -> [CityModel] {
		return []
	}

	func getAirports() -> [AirportModel] {
		return []
	}
}
