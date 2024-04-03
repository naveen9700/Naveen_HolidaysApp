//
//  APIServiceTests.swift
//  Naveen_HolidaysApp
//
//  Created by kunchal on 03/04/24.
//

import XCTest
@testable import Naveen_HolidaysApp

final class APIServiceTests: XCTestCase {

	var apiService: APIService!

	override func setUpWithError() throws {
		apiService = APIService()
	}

	func testFetchHolidaysSuccess() {
		// Given
		let country = "US"
		let expectation = self.expectation(description: "Fetch holidays success")
		
		// When
		apiService.fetchHolidays(for: country) { result in
			// Then
			switch result {
			case .success(let holidays):
				XCTAssertFalse(holidays.isEmpty)
				expectation.fulfill()
			case .failure(let error):
				XCTFail("Expected success, got failure with error: \(error)")
			}
		}
		
		waitForExpectations(timeout: 5, handler: nil)
	}

	func testFetchHolidaysInvalidURL() {
		// Given
		let country = "InvalidCountry"
		let expectation = self.expectation(description: "Fetch holidays invalid URL")
		
		// When
		apiService.fetchHolidays(for: country) { result in
			// Then
			switch result {
			case .success:
				XCTFail("Expected failure, got success")
			case .failure(let error):
				XCTAssertEqual(error, .invalidURL)
				expectation.fulfill()
			}
		}
		
		waitForExpectations(timeout: 5, handler: nil)
	}
}
