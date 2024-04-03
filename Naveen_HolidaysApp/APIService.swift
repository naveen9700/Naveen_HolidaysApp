//
//  APIService.swift
//  Naveen_HolidaysAPP
//
//  Created by kunchal on 02/04/24.
//

import Foundation


enum APIError: Error {
	case invalidURL
	case noData
	case decodingError
}

class APIService {
	func fetchHolidays(for country: String, completion: @escaping (Result<[HoliDayModel], APIError>) -> Void) {
		let urlString = "https://date.nager.at/api/v2/publicholidays/2024/\(country)"
		guard let url = URL(string: urlString) else {
			completion(.failure(.invalidURL))
			return
		}
		URLSession.shared.dataTask(with: url) { data, response, error in
			if let error = error {
				print("Error fetching holidays: \(error)")
				completion(.failure(.noData))
				return
			}
			guard let data = data else {
				completion(.failure(.noData))
				return
			}
			do {
				let holidays = try JSONDecoder().decode([HoliDayModel].self, from: data)
				completion(.success(holidays))
			} catch {
				print("Decoding error: \(error)")
				completion(.failure(.invalidURL))
			}
		}.resume()
	}
}

class MockAPIService: APIService {
	var shouldFail = false

	override func fetchHolidays(for country: String, completion: @escaping (Result<[HoliDayModel], APIError>) -> Void) {
		if shouldFail {
			completion(.failure(.noData)) 
		} else {
			let holidays: [HoliDayModel] = [] 
			completion(.success(holidays))
		}
	}
}

extension String {
	// Convert date string from "yyyy-MM-dd" format to "EEE dd/MM/yyyy" format
	func convertDateString() -> String? {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy-MM-dd"
		if let date = dateFormatter.date(from: self) {
			dateFormatter.dateFormat = "EEE dd/MM/yyyy"
			return dateFormatter.string(from: date)
		}
		return nil
	}
}
