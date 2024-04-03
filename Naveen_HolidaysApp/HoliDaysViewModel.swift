//
//  HoliDaysViewModel.swift
//  Naveen_HolidaysAPP
//
//  Created by kunchal on 02/04/24.
//

import Foundation
class HolidaysViewModel {
	private let apiService: APIService
	var holidays: [HoliDayModel] = []
	
	init(apiService: APIService = APIService()) {
		self.apiService = apiService
	}
	
	func fetchHolidays(for country: String, completion: @escaping () -> Void) {
		DispatchQueue.global(qos: .userInitiated).async {
			self.apiService.fetchHolidays(for: country) { [weak self] result in
				switch result {
				case .success(let holidays):
					self?.holidays = holidays
					completion()
				case .failure(let error):
					print("Failed to fetch holidays: \(error)")
					completion() 
				}
			}
		}
	}
}
