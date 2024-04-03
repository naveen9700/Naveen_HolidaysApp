//
//  ViewController.swift
//  Naveen_HolidaysApp
//
//  Created by kunchal on 03/04/24.
//

import UIKit

class ViewController: UIViewController {
	
	@IBOutlet weak var tableView: UITableView!
	var viewModel:HolidaysViewModel!
 
	@IBOutlet var activityIndicator: UIActivityIndicatorView!
	override func viewDidLoad() {
	 super.viewDidLoad()
	 
	 self.navigationItem.title = "Holidays List US"	 
	 self.navigationItem.largeTitleDisplayMode = .always
	 navigationController!.navigationBar.prefersLargeTitles = true
	 
	 let apiService = APIService()
	 viewModel = HolidaysViewModel(apiService: apiService)
	 
	 setupTableView()
	 fetchHolidays()
 }
 
 private func setupTableView() {
	 tableView.dataSource = self
	 tableView.delegate = self
	 tableView.register(UINib(nibName: "HolidayTableViewCell", bundle: nil), forCellReuseIdentifier: "HolidayTableViewCell")
 }
 
 private func fetchHolidays() {
	 activityIndicator.isHidden = false
	 activityIndicator.startAnimating()
	 viewModel.fetchHolidays(for: "US") { [weak self] in
		 DispatchQueue.main.async {
			 self?.tableView.reloadData()
			 self?.activityIndicator.isHidden = true

		 }
	 }
 }
}

extension ViewController: UITableViewDataSource,UITableViewDelegate {
	
 func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
	 return viewModel.holidays.count
 }
 
 func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
	 let cell = tableView.dequeueReusableCell(withIdentifier: "HolidayTableViewCell", for: indexPath) as! HolidayTableViewCell
	 let holiday = viewModel.holidays[indexPath.row]
	 cell.dateLbl.text = holiday.date.convertDateString() ?? ""
	 cell.holidayNameLbl.text = holiday.name
	 
	 return cell
 }
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 80
	}
	
}


