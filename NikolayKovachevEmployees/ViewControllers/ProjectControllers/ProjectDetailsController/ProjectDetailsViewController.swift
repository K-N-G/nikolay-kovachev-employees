//
//  ProjectDetailsViewController.swift
//  NikolayKovachevEmployees
//
//  Created by KNG on 31.03.24.
//

import UIKit

class ProjectDetailsViewController: UIViewController {
    
    var project: Project?
    var employees:[(employeeID: String, daysWorked: Int)] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "ProjectID: \(project?.id ?? "")"
        if let project = project {
            for employee in project.employees {
                self.employees.append((employee.key, employee.value))
            }
        }
    }
}

extension ProjectDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        employees.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let projectDetailsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ProjectDetailsTableViewCell", for: indexPath) as? ProjectDetailsTableViewCell {
            projectDetailsTableViewCell.employeeIDValueLabel.text = self.employees[indexPath.row].employeeID
            projectDetailsTableViewCell.workedDaysValueLabel.text = "\(self.employees[indexPath.row].daysWorked)"
            return projectDetailsTableViewCell
        }
        
        return UITableViewCell()
    }
    
    
}

