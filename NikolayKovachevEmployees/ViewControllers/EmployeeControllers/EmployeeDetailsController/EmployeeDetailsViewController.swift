//
//  EmployeeDetailsViewController.swift
//  NikolayKovachevEmployees
//
//  Created by KNG on 31.03.24.
//

import UIKit

class EmployeeDetailsViewController: UIViewController {
    
    var employee: Employee?
    var projects:[(projectID: String, daysWorked: Int)] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "EmploeeID: \(employee?.id ?? "")"
        if let employee = employee {
            for product in employee.projects {
                self.projects.append((product.key, product.value))
            }
        }
        
    }
}

extension EmployeeDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        projects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let employeeDetailsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "EmployeeDetailsTableViewCell", for: indexPath) as? EmployeeDetailsTableViewCell {
            employeeDetailsTableViewCell.projectIDValueLabel.text = self.projects[indexPath.row].projectID
            employeeDetailsTableViewCell.workedDaysValueLabel.text = "\(self.projects[indexPath.row].daysWorked)"
            return employeeDetailsTableViewCell
        }
        
        
        return UITableViewCell()
    }
    
    
}

