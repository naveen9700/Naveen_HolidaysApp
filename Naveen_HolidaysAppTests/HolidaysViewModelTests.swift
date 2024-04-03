//
//  HolidaysViewModelTests.swift
//  Naveen_HolidaysAppTests
//
//  Created by kunchal on 03/04/24.
//


import XCTest
@testable import Naveen_HolidaysApp


final class HolidaysViewModelTests: XCTestCase {
	
	var viewModel: HolidaysViewModel!
	var mockAPIService: MockAPIService!  
		
		override func setUpWithError() throws {
			mockAPIService = MockAPIService()  
			viewModel = HolidaysViewModel(apiService: mockAPIService)
		}
	func testFetchHolidaysSuccess() {
		// Given
		let expectation = self.expectation(description: "Fetch holidays success")
		
		// When
		viewModel.fetchHolidays(for: "US") {
			// Then
			XCTAssertGreaterThanOrEqual(self.viewModel.holidays.count, 0)
			expectation.fulfill()
		}
		
		waitForExpectations(timeout: 5, handler: nil)
	}
	
	func testFetchHolidaysFailure() {
		// Given
		mockAPIService.shouldFail = true
		let expectation = self.expectation(description: "Fetch holidays failure")
		
		// When
		viewModel.fetchHolidays(for: "US") {
			XCTAssertTrue(self.viewModel.holidays.isEmpty) 
			expectation.fulfill()
		}
		
		waitForExpectations(timeout: 50) { error in
			if let error = error {
				XCTFail("Timeout error: \(error)") 
			}
		}
	}


}
