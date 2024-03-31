//
//  PairOfEmployeesTableViewCell.swift
//  NikolayKovachevEmployees
//
//  Created by KNG on 29.03.24.
//

import UIKit

class PairOfEmployeesTableViewCell: UITableViewCell {
    @IBOutlet weak var employee1Label: UILabel!
    @IBOutlet weak var employee2Label: UILabel!
    @IBOutlet weak var projectIDLabel: UILabel!
    @IBOutlet weak var daysWorkedTogetherLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
