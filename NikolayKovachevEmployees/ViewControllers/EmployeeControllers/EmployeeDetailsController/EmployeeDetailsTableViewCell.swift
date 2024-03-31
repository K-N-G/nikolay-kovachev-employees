//
//  EmployeeDetailsTableViewCell.swift
//  NikolayKovachevEmployees
//
//  Created by KNG on 31.03.24.
//

import UIKit

class EmployeeDetailsTableViewCell: UITableViewCell {
    @IBOutlet weak var projectIDValueLabel: UILabel!
    @IBOutlet weak var workedDaysValueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
