//
//  EmployeeViewController.swift
//  NikolayKovachevEmployees
//
//  Created by KNG on 29.03.24.
//

import UIKit

class EmployeeViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var rows:[EmployeeRow] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupScreen()
    }
    
    func setupScreen() {
        self.rows = []
        
        if DataManager.employees.isEmpty {
            self.rows.append(EmployeeRow(type: .loadCSV, employee: nil))
        } else {
            for employee in DataManager.employees {
                self.rows.append(EmployeeRow(type: .employee, employee: employee))
            }
        }
//        self.rows.append(EmployeeRow(type: .missingData))
        
        self.tableView.reloadData()
    }
}

extension EmployeeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = self.rows[indexPath.row]
        
        switch row.type {
        case .loadCSV:
            if let loadCSVTableViewCell = tableView.dequeueReusableCell(withIdentifier: "LoadCSVTableViewCell", for: indexPath) as? LoadCSVTableViewCell {
                return loadCSVTableViewCell
            }
        case .employee:
            if let employeeTableViewCell = tableView.dequeueReusableCell(withIdentifier: "EmployeeTableViewCell", for: indexPath) as? EmployeeTableViewCell,
               let employee = row.employee {
                employeeTableViewCell.employeeIDLabel.text = employee.id
                return employeeTableViewCell
            }
        case .missingData:
            if let missingDataTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MissingDataTableViewCell", for: indexPath) as? MissingDataTableViewCell {
                return missingDataTableViewCell
            }
        }
        
        return UITableViewCell()
    }
}

extension EmployeeViewController {
    struct EmployeeRow {
        enum RowType {
            case loadCSV
            case employee
            case missingData
        }

        let type: RowType
        let employee: Employee?
    }
}
