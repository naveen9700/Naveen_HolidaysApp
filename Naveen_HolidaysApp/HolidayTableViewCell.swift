//
//  HolidayTableViewCell.swift
//  Naveen_HolidaysAPP
//
//  Created by kunchal on 02/04/24.
//

import UIKit

class HolidayTableViewCell: UITableViewCell {

	
	@IBOutlet var bgView: UIView!
	
	@IBOutlet var holidayNameLbl: UILabel!
	@IBOutlet var dateLbl: UILabel!
	
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
		bgView.layer.shadowColor = UIColor.black.cgColor
		bgView.layer.shadowOffset = CGSize(width: 0, height: 1)
		bgView.layer.shadowOpacity = 0.5
		bgView.layer.shadowRadius = 4
		bgView.layer.cornerRadius = 8
    }
	
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
